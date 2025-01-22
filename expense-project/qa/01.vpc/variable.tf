variable "environment" {
  type        = string
  description = "The environment for the deployment (e.g., dev, stage, prod)."
}

variable "project_name" {
  type        = string
  description = "The name of the project."
}

variable "common_tags" {
  type        = map(any)
  description = "A map of common tags to apply to resources."
}

