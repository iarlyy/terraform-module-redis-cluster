variable "name" {}
variable "vpc_id" {}
variable "subnet_group_name" {}
variable "node_type" {}

variable "engine" {
  default = "redis"
}

variable "engine_version" {
  default = "4.0.10"
}

variable "num_cache_nodes" {
  default = 1
}

variable "parameter_group_name" {
  default = "default.redis4.0"
}

variable "port" {
  default = "6379"
}

variable "security_group_ids" {
  default = []
}

variable "az_mode" {
  default = "single-az"
}
