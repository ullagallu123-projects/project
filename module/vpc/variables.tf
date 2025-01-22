variable "azs" {
  type        = list(string)
  description = "A list of availability zones for the region."
}

variable "public_subnet_cidr" {
  type        = list(string)
  description = "A list of CIDR blocks for public subnets."
}

variable "private_subnet_cidr" {
  type        = list(string)
  description = "A list of CIDR blocks for private subnets."
}

variable "db_subnet_cidr" {
  type        = list(string)
  description = "A list of CIDR blocks for database subnets."
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC."
}

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

variable "enable_nat" {
  type        = bool
  description = "Whether to enable NAT gateways for private subnets."
}

variable "vpc_peering_enable" {
  type        = bool
  description = "Whether to enable VPC peering."
}
