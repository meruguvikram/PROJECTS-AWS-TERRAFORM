# CloudWatch Log Group for Application Logs
resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/aws/application/cooking-recipes"
  retention_in_days = 7
}

# CloudWatch Log Group for Auto Scaling Group
resource "aws_cloudwatch_log_group" "asg_log_group" {
  name              = "/aws/ec2/asg-cooking-recipes"
  retention_in_days = 7
}

# Enable CloudWatch Logs for Launch Template User Data (EC2 Instance Logs)
resource "aws_cloudwatch_log_stream" "ec2_log_stream" {
  name           = "ec2-instance-logs"
  log_group_name = aws_cloudwatch_log_group.asg_log_group.name
}

# Create CloudWatch Logs Policy
resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name        = "CloudWatchLogsPolicy"
  description = "Allows EC2 instances to publish logs to CloudWatch"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Attach CloudWatch Logs Policy to EC2 IAM Role
resource "aws_iam_role_policy_attachment" "attach_cloudwatch_logs_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}

# Scaling Policies for Auto Scaling Group
# Scale Out Policy
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale_out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

# Scale In Policy
resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale_in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

# CloudWatch Metric for Auto Scaling Group CPU Utilization High
resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  alarm_name          = "ASG_CPU_Utilization_High"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Triggers if CPU utilization is over 80% for 10 minutes"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}

# CloudWatch Metric for Auto Scaling Group CPU Utilization Low
resource "aws_cloudwatch_metric_alarm" "asg_cpu_low" {
  alarm_name          = "ASG_CPU_Utilization_Low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 20
  alarm_description   = "Triggers if CPU utilization is below 20% for 10 minutes"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_in.arn]
}

# CloudWatch Metric for DynamoDB Read Capacity
resource "aws_cloudwatch_metric_alarm" "dynamodb_read_capacity" {
  alarm_name          = "DynamoDB_Read_Capacity_High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ConsumedReadCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = 300
  statistic           = "Sum"
  threshold           = 100
  alarm_description   = "Triggers if DynamoDB read capacity exceeds 100"
  dimensions = {
    TableName = aws_dynamodb_table.recipes.name
  }
}

# CloudWatch Metric for DynamoDB Write Capacity
resource "aws_cloudwatch_metric_alarm" "dynamodb_write_capacity" {
  alarm_name          = "DynamoDB_Write_Capacity_High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ConsumedWriteCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = 300
  statistic           = "Sum"
  threshold           = 100
  alarm_description   = "Triggers if DynamoDB write capacity exceeds 100"
  dimensions = {
    TableName = aws_dynamodb_table.recipes.name
  }
}

# CloudWatch Alarm for S3 Bucket 403 Errors
resource "aws_cloudwatch_metric_alarm" "s3_403_errors" {
  alarm_name          = "S3_403_Errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "4xxErrorRate"
  namespace           = "AWS/S3"
  period              = 300
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Triggers if 403 errors occur on the S3 bucket"
  dimensions = {
    BucketName = aws_s3_bucket.frontend.bucket
    FilterId   = "EntireBucket"
  }
}
