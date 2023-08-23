variable "region" {
  default = "ap-northeast-2"
}

variable "project_name" {}
variable "env" {}
variable "s3_name" {}

locals {
  project_name = var.project_name
  env = var.env
  s3_name = var.s3_name

  tags = {
  }
}
