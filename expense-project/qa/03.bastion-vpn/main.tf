locals {
  bastion_sg        = data.aws_ssm_parameter.bastion.value
  vpn_sg            = data.aws_ssm_parameter.vpn.value
  amazon_ami        = data.aws_ami.amazon_linux.id
  open_vpn_ami      = data.aws_ami.openvpn.id
  public_subnet_ids = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)
}

module "bastion_instance" {
  source                 = "../../../module/ec2/"
  environment            = var.environment
  project_name           = var.project_name
  ami                    = local.amazon_ami
  instance_name          = "bastion"
  instance_type          = "t3.micro"
  key_name               = var.key_name
  subnet_id              = local.public_subnet_ids
  vpc_security_group_ids = [local.bastion_sg]
  common_tags            = var.common_tags
}

module "vpn_instance" {
  source                 = "../../../module/ec2/"
  environment            = var.environment
  project_name           = var.project_name
  ami                    = local.open_vpn_ami
  instance_name          = "vpn"
  instance_type          = "t3a.small"
  key_name               = var.key_name
  subnet_id              = local.public_subnet_ids
  vpc_security_group_ids = [local.vpn_sg]
  common_tags            = var.common_tags
}