module "backend-asg"{
    source = "../../../module/expense-asg"
    environment = "qa"
    project_name = "expense"
    common_tags = {
    "Terraform"   = "true"
    "Author"      = "sivaramakrishna"
    "Environment" = "qa"
    "Project"     = "expense"
    "Component"   = "backend-asg"
  }
  ami_id = data.aws_ami.backend.id
  instance_type = "t3.micro"
  key_name = "bapatlas.site"
  vpc_security_group_ids = [data.aws_ssm_parameter.backend.value]

  port = 8080
  health_check_path = "/health"
  vpc_id = data.aws_ssm_parameter.vpc_id.value

  asg_max_size = 1
  asg_min_size = 1
  desired_capacity = 1
  health_check_grace_period = 90
  subnets = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
  target_value = 10

  listener_arn = split(",",data.aws_ssm_parameter.http_listner.value)
  component = "internal"
  zone_name = "bapatlas.site"

}