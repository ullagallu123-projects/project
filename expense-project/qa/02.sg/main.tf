locals {
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}
module "bastion" {
  source         = "../../../module/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "This was used for bastion"
  common_tags    = var.common_tags
  vpc_id         = local.vpc_id
  sg_name        = "bastion"
}
module "vpn" {
  source         = "../../../module/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "This was used for vpn"
  common_tags    = var.common_tags
  vpc_id         = local.vpc_id
  sg_name        = "vpn"
}

module "db" {
  source         = "../../../module/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "This was used for db"
  common_tags    = var.common_tags
  vpc_id         = local.vpc_id
  sg_name        = "db"
}
module "backend" {
  source         = "../../../module/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "This was used for backend"
  common_tags    = var.common_tags
  vpc_id         = local.vpc_id
  sg_name        = "backend"
}

module "frontend" {
  source         = "../../../module/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "This was used for frontend"
  common_tags    = var.common_tags
  vpc_id         = local.vpc_id
  sg_name        = "frontend"
}
module "internal_lb" {
  source         = "../../../module/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "This was used for internal_lb"
  common_tags    = var.common_tags
  vpc_id         = local.vpc_id
  sg_name        = "internal_lb"
}

module "external_lb" {
  source         = "../../../module/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "This was used for external_lb"
  common_tags    = var.common_tags
  vpc_id         = local.vpc_id
  sg_name        = "external_lb"
}