# CloudWatch Log Groups
resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "${var.project_name}-${var.environment}-app-log-group"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "asg_log_group" {
  name              = "${var.project_name}-${var.environment}-asg-log-group"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "alb_log_group" {
  name              = "${var.project_name}-${var.environment}-alb-log-group"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "cloudfront_log_group" {
  name              = "${var.project_name}-${var.environment}-cloudfront-log-group"
  retention_in_days = 7
}

# CloudWatch Log Streams for Application Logs
resource "aws_cloudwatch_log_stream" "app_log_stream" {
  name           = "${var.project_name}-${var.environment}-app-log-stream"
  log_group_name = aws_cloudwatch_log_group.app_log_group.name
}

resource "aws_cloudwatch_log_stream" "asg_log_stream" {
  name           = "${var.project_name}-${var.environment}-asg-log-stream"
  log_group_name = aws_cloudwatch_log_group.asg_log_group.name
}

# CloudWatch Metrics and Alarms for EC2 Instances
resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  alarm_name          = "${var.project_name}-${var.environment}-ec2-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Triggers if EC2 instance CPU utilization exceeds 80% for 2 minutes"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out.arn]
  ok_actions    = [aws_autoscaling_policy.scale_in.arn]
}

# CloudWatch Metrics and Alarms for ALB
resource "aws_cloudwatch_metric_alarm" "alb_5xx_errors" {
  alarm_name          = "${var.project_name}-${var.environment}-alb-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "Triggers if ALB receives 5xx errors"
  dimensions = {
    LoadBalancer = aws_lb.application_load_balancer.arn_suffix
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

# CloudWatch Metrics and Alarms for DynamoDB
resource "aws_cloudwatch_metric_alarm" "dynamodb_read_capacity" {
  alarm_name          = "${var.project_name}-${var.environment}-dynamodb-read-capacity-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ConsumedReadCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = 60
  statistic           = "Sum"
  threshold           = 100
  alarm_description   = "Triggers if DynamoDB read capacity exceeds 100"
  dimensions = {
    TableName = aws_dynamodb_table.recipes.name
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "dynamodb_write_capacity" {
  alarm_name          = "${var.project_name}-${var.environment}-dynamodb-write-capacity-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ConsumedWriteCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = 60
  statistic           = "Sum"
  threshold           = 100
  alarm_description   = "Triggers if DynamoDB write capacity exceeds 100"
  dimensions = {
    TableName = aws_dynamodb_table.recipes.name
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

# CloudWatch Metrics and Alarms for CloudFront
resource "aws_cloudwatch_metric_alarm" "cloudfront_4xx_errors" {
  alarm_name          = "${var.project_name}-${var.environment}-cloudfront-4xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "4xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Triggers if CloudFront receives 4xx errors"
  dimensions = {
    DistributionId = aws_cloudfront_distribution.frontend.id
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "cloudfront_5xx_errors" {
  alarm_name          = "${var.project_name}-${var.environment}-cloudfront-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "5xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Triggers if CloudFront receives 5xx errors"
  dimensions = {
    DistributionId = aws_cloudfront_distribution.frontend.id
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

# CloudWatch Logs for S3 Bucket
resource "aws_cloudwatch_metric_alarm" "s3_4xx_errors" {
  alarm_name          = "${var.project_name}-${var.environment}-s3-4xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "4xxErrorRate"
  namespace           = "AWS/S3"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Triggers if S3 bucket receives 4xx errors"
  dimensions = {
    BucketName = aws_s3_bucket.frontend.bucket
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "s3_5xx_errors" {
  alarm_name          = "${var.project_name}-${var.environment}-s3-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "5xxErrorRate"
  namespace           = "AWS/S3"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Triggers if S3 bucket receives 5xx errors"
  dimensions = {
    BucketName = aws_s3_bucket.frontend.bucket
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}
