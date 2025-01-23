module "expense_vpc" {
  source              = "../../../module/vpc/"
  azs                 = ["us-east-1a", "us-east-1b"]
  vpc_cidr            = "10.1.0.0/16"
  public_subnet_cidr  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidr = ["10.1.3.0/24", "10.1.4.0/24"]
  db_subnet_cidr      = ["10.1.5.0/24", "10.1.6.0/24"]

  environment        = var.environment
  project_name       = var.project_name
  common_tags        = var.common_tags
  enable_nat         = false
  vpc_peering_enable = false
}