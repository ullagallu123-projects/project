variable "project_name" {
  description = "Name of the project to be used as an identifier."
  type        = string

}

variable "environment" {
  description = "Environment name, such as 'dev', 'staging', or 'prod'."
  type        = string

}
variable "common_tags" {
  description = "Tags to be applied to all resources."
  type        = map(string)

}

variable "key_name" {}

