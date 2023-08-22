variable "project_name" {
  description = "project name"
  default     = "study4"
}

variable "name" {
  description = "My name"
  default     = "yeji"
}

variable "seoul_region" {
  description = "seoul region name"
  default     = "ap-northeast-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR BLOCK : x.x.x.x/x"
  default     = "192.168.0.0/16"
}


locals {
  project_name = var.project_name
  name         = var.name
  vpc_cidr     = var.vpc_cidr
  seoul_region = var.seoul_region
}