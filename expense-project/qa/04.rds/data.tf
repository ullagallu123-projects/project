data "aws_ssm_parameter" "db_subnet_group" {
  name = "/${var.environment}/${var.project_name}/db-subnet-group"
}
data "aws_ssm_parameter" "db" {
  name = "/${var.environment}/${var.project_name}/db-sg"
}