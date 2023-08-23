# module "vpc" {
#   source       = "../module/vpc"
#   vpc_cidr     = local.vpc_cidr
#   project_name = local.project_name
#   name         = local.name
# }

module "s3" {
  source       = "../module/s3"
  project_name = local.project_name
  env          = local.env
  s3_name      = local.s3_name
}

