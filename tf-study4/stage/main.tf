module "vpc" {
  source       = "../module/vpc"
  vpc_cidr     = local.vpc_cidr
  project_name = local.project_name
  name         = local.name
}

