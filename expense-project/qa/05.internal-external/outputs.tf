output "acm" {
  value = module.expense_acm_external.certificate_arn
}
output "internal_http_listner" {
  value = module.expense_internal.http_listner
}

output "external_http_listner" {
  value = module.expense_external.http_listner
}
output "external_https_listner" {
  value = module.expense_external.https_listner
}