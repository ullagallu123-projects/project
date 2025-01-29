module "backend_asg"{
    source = "../../../module/expesne-asg"
    environment = var.environment
    project_name = var.project_name
    common_tags = {
    "Terraform"   = "true"
    "Author"      = "sivaramakrishna"
    "Environment" = "qa"
    "Project"     = "expense"
    "Component"   = "backend-asg"
  }
    ami_id = data.aws_ami.backend.id
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [data.aws_ssm_parameter.backend.value]
    port = 8080
    health_check_path = "/health"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    asg_max_size = 1
    asg_min_size = 1
    desired_capacity = 1
    health_check_grace_period  = 60
    subnets = split(",",data.aws_ssm_parameter.private_subnet_ids.value)

    target_value = 10
    listener_arn = data.aws_ssm_parameter.internal_http_listner.value
    component = "internal"
    zone_name = var.zone_name
}

module "frontend_asg"{
    source = "../../../module/expesne-asg"
    environment = var.environment
    project_name = var.project_name
    common_tags = {
    "Terraform"   = "true"
    "Author"      = "sivaramakrishna"
    "Environment" = "qa"
    "Project"     = "expense"
    "Component"   = "frontend-asg"
  }
    ami_id = data.aws_ami.frontend.id
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [data.aws_ssm_parameter.frontend.value]
    port = 80
    health_check_path = "/health"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    asg_max_size = 1
    asg_min_size = 1
    desired_capacity = 1
    health_check_grace_period  = 60
    subnets = split(",",data.aws_ssm_parameter.private_subnet_ids.value)

    target_value = 10
    listener_arn = data.aws_ssm_parameter.external_https_listner.value
    component = "external"
    zone_name = var.zone_name

}