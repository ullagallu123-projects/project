# Locals
locals {
    name = "${var.environment}-${var.project_name}-${var.component}"
}
resource "aws_launch_template" "test" {
  name               = local.name
  image_id           = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

  tag_specifications {
    resource_type = "instance"
    tags = merge({ Name = "${var.environment}-${var.project_name}" }, var.common_tags)
  }
}

resource "aws_lb_target_group" "test" {
  name     = local.name
  port     = var.port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    healthy_threshold   = 2
    unhealthy_threshold = 5
    protocol            = "HTTP"
    port                = var.port
    matcher             = "200-299"
  }
}

resource "aws_autoscaling_group" "app" {
  name                      = local.name
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity
  target_group_arns = [aws_lb_target_group.test.arn]  
  launch_template {
        id      = aws_launch_template.test.id
        version = "$Latest"
  }  
  vpc_zone_identifier       = var.subnets

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  tag {
    key                 = "Name"
    value               = local.name
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = false
  }
}

resource "aws_autoscaling_policy" "aap" {
  name                   = local.name
  autoscaling_group_name = aws_autoscaling_group.app.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.target_value
  }
}

resource "aws_lb_listener_rule" "http" {
  listener_arn = var.listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
  condition {
    host_header {
      values = ["${local.name}.${var.zone_name}"]
    }
  }
}
