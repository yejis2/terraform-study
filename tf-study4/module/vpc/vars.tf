variable "project_name" {}

variable "name" {}

variable "vpc_cidr" {}

locals {
  project_name = var.project_name
  name = var.name
  vpc_cidr = var.vpc_cidr
}