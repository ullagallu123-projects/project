resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.environment}/${var.project_name}/vpc-id"
  type  = "String"
  value = module.expense_vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.environment}/${var.project_name}/public-subnet-ids"
  type  = "StringList"
  value = join(",", module.expense_vpc.public_subnet_id)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.environment}/${var.project_name}/private-subnet-ids"
  type  = "StringList"
  value = join(",", module.expense_vpc.private_subnet_id)
}

resource "aws_ssm_parameter" "db_subnet_ids" {
  name  = "/${var.environment}/${var.project_name}/db-subnet-ids"
  type  = "StringList"
  value = join(",", module.expense_vpc.db_subnet_id)
}

resource "aws_ssm_parameter" "db_subnet_group" {
  name  = "/${var.environment}/${var.project_name}/db-subnet-group"
  type  = "String"
  value = module.expense_vpc.db_subnet_group
}
