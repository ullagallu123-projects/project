data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.environment}/${var.project_name}/public-subnet-ids"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.environment}/${var.project_name}/private-subnet-ids"
}

data "aws_ssm_parameter" "internal_lb_sg" {
  name = "/${var.environment}/${var.project_name}/internal-sg"
}

data "aws_ssm_parameter" "external_lb_sg" {
  name = "/${var.environment}/${var.project_name}/external-sg"
}