data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}

resource "aws_security_group" "redis_instance" {
  name   = "redis-${var.name}"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "${var.port}"
    to_port     = "${var.port}"
    protocol    = "TCP"
    cidr_blocks = ["${data.aws_vpc.vpc.cidr_block}"]
    self        = true
  }

  tags {
    Name      = "redis-${var.name}"
    Terraform = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elasticache_cluster" "redis_instance" {
  cluster_id           = "${var.name}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  node_type            = "${var.node_type}"
  num_cache_nodes      = "${var.num_cache_nodes}"
  parameter_group_name = "${var.parameter_group_name}"
  port                 = "${var.port}"
  security_group_ids   = ["${var.security_group_ids}"]
  security_group_ids   = ["${concat(list(aws_security_group.redis_instance.id), var.security_group_ids)}"]

  az_mode           = "${var.az_mode}"
  subnet_group_name = "${var.subnet_group_name}"

  tags {
    Terraform = true
  }
}
