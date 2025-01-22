variable "project_name" {
  description = "Name of the project to be used as an identifier."
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name, such as 'dev', 'staging', or 'prod'."
  type        = string
  default     = ""
}
variable "common_tags" {
  description = "Tags to be applied to all resources."
  type        = map(string)
  default     = {}
}

