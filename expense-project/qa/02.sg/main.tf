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

# DB Rules
resource "aws_security_group_rule" "bastion_db" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.db.sg_id
}
resource "aws_security_group_rule" "vpn_db" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.db.sg_id
}
resource "aws_security_group_rule" "backend_db" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.backend.sg_id
  security_group_id        = module.db.sg_id
}

# Backend Rules
resource "aws_security_group_rule" "bastion_backend" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.backend.sg_id
}
resource "aws_security_group_rule" "vpn_backend" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.backend.sg_id
}
resource "aws_security_group_rule" "internal_lb_backend" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.internal_lb.sg_id
  security_group_id        = module.backend.sg_id
}

# InternalLB Rules
resource "aws_security_group_rule" "bastion_internal_lb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.internal_lb.sg_id
}
resource "aws_security_group_rule" "vpn_internal_lb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.internal_lb.sg_id
}
resource "aws_security_group_rule" "frontend_internal_lb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.internal_lb.sg_id
}

# Frontend Rules
resource "aws_security_group_rule" "bastion_frontend" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.frontend.sg_id
}
resource "aws_security_group_rule" "vpn_frontend" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.frontend.sg_id
}
resource "aws_security_group_rule" "external_lb_frontend" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.external_lb.sg_id
  security_group_id        = module.frontend.sg_id
}

# Bastion Rules
resource "aws_security_group_rule" "anywhere_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

# ExternalLB Rules
resource "aws_security_group_rule" "anywhere_http_external_lb" {
  description       = "allow traffic from 80 from anywhere"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.external_lb.sg_id
}
resource "aws_security_group_rule" "anywhere_https_external_lb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.external_lb.sg_id
}

# VPN Rules
# VPN
resource "aws_security_group_rule" "vpn_ssh" {
  description       = "This rule allows all traffic from internet on 22"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_https" {
  description       = "This rule allows all traffic from internet on 443"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_et" {
  description       = "This rule allows all traffic from internet on 943"
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_udp" {
  description       = "This rule allows all traffic from internet on 1194"
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
