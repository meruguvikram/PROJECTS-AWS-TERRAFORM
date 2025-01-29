# Launch Template for Auto Scaling Group
resource "aws_launch_template" "app_launch_template" {
  name          = "${var.project_name}-${var.environment}-launch-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  description   = "launch template for asg"

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [aws_security_group.asg_security_group.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_combined_profile.name
  }

  # Inject file contents into userdata.tpl
  user_data = base64encode(templatefile("${path.module}/userdata.tpl", {
    PROJECT_DIR = "/home/ubuntu/cea_students_projects_sharing_app/backend",
  }))
}

# Create Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = [aws_subnet.private_app_subnet_az1.id, aws_subnet.private_app_subnet_az2.id]
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2
  name                = "${var.project_name}-${var.environment}-asg"
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.environment}-asg"
    propagate_at_launch = true
  }
}

# Attach Auto Scaling Group to ALB Target Group
resource "aws_autoscaling_attachment" "asg_alb_target_group_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.alb_tg.arn
}

# Scale Out Policy
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "${var.project_name}-${var.environment}-scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

# Scale In Policy
resource "aws_autoscaling_policy" "scale_in" {
  name                   = "${var.project_name}-${var.environment}-scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}
