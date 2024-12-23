# Create an Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  name             = "${var.project_name}-${var.environment}-asg"
  min_size         = var.asg_min
  max_size         = var.asg_max
  desired_capacity = var.asg_des_cap
  vpc_zone_identifier = [
    aws_subnet.private_app_subnet_az1.id,
    aws_subnet.private_app_subnet_az2.id
  ]

  launch_template {
    id      = aws_launch_template.lt-asg.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.environment}-asg"
    propagate_at_launch = true
  }
}

# Create a launch template with the specified configurations
resource "aws_launch_template" "lt-asg" {
  name_prefix            = "${var.project_name}-${var.environment}-lt"
  image_id               = var.lt_asg_ami
  instance_type          = var.lt_asg_instance_type
  vpc_security_group_ids = [aws_security_group.lt_sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_instance_profile.name
  }

  user_data = filebase64("${path.root}/install-apache.sh")
}

# Attach the autoscaling group to the target group of the ALB
resource "aws_autoscaling_attachment" "asg-tg-attach" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.alb_tg.arn
}

