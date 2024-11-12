# Launch Template for Auto Scaling Group
resource "aws_launch_template" "app_launch_template" {
  name          = var.launch_template_name
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  description   = "launch template for asg"

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [aws_security_group.asg_security_group.id]

  user_data = base64encode(templatefile("${path.module}/userdata.tpl", {
    GitRepoURL = var.github_repository
  }))
}

# create auto scaling group
# terraform aws autoscaling group
resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = [aws_subnet.private_app_subnet_az1.id, aws_subnet.private_app_subnet_az2.id]
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  name                = "dev-asg"
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg"
    propagate_at_launch = true
  }
}

# attach auto scaling group to alb target group
# terraform aws autoscaling attachment
resource "aws_autoscaling_attachment" "asg_alb_target_group_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.alb_target_group.arn
}