resource "aws_ssm_parameter" "internal_http_listner" {
  name  = "/${var.environment}/${var.project_name}/internal-http-listner"
  type  = "StringList"
  value = join(",", module.expense_internal.http_listner)
}

resource "aws_ssm_parameter" "external_http_listner" {
  name  = "/${var.environment}/${var.project_name}/external-http-listner"
  type  = "StringList"
  value = join(",", module.expense_external.http_listner)
}
resource "aws_ssm_parameter" "external_https_listner" {
  name  = "/${var.environment}/${var.project_name}/external-https-listner"
  type  = "StringList"
  value = join(",", module.expense_external.https_listner)
}