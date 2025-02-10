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

# CloudWatch Log Streams (only for application logs where custom streaming is needed)
resource "aws_cloudwatch_log_stream" "app_log_stream" {
  name           = "${var.project_name}-${var.environment}-app-log-stream"
  log_group_name = aws_cloudwatch_log_group.app_log_group.name
}

# CloudWatch Metrics and Alarms for EC2 Instances
resource "aws_cloudwatch_metric_alarm" "asg_cpu_warning" {
  alarm_name          = "${var.project_name}-${var.environment}-ec2-cpu-warning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Warning: EC2 instance CPU utilization exceeds 70% for 15 minutes"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "asg_cpu_critical" {
  alarm_name          = "${var.project_name}-${var.environment}-ec2-cpu-critical"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 85
  alarm_description   = "Critical: EC2 instance CPU utilization exceeds 85% for 10 minutes"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out.arn, "${aws_sns_topic.alerts.arn}"]
  ok_actions    = [aws_autoscaling_policy.scale_in.arn]
}

resource "aws_cloudwatch_metric_alarm" "asg_memory_warning" {
  alarm_name          = "${var.project_name}-${var.environment}-ec2-memory-warning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Warning: EC2 instance memory utilization exceeds 70% for 15 minutes"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "asg_memory_critical" {
  alarm_name          = "${var.project_name}-${var.environment}-ec2-memory-critical"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = 85
  alarm_description   = "Critical: EC2 instance memory utilization exceeds 85% for 10 minutes"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out.arn, "${aws_sns_topic.alerts.arn}"]
}

# CloudWatch Metrics and Alarms for ALB
resource "aws_cloudwatch_metric_alarm" "alb_5xx_errors" {
  alarm_name          = "${var.project_name}-${var.environment}-alb-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Sum"
  threshold           = 50
  alarm_description   = "Critical: ALB is generating too many 5XX errors"
  dimensions = {
    LoadBalancer = aws_lb.application_load_balancer.arn_suffix
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "alb_latency_warning" {
  alarm_name          = "${var.project_name}-${var.environment}-alb-latency-warning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Average"
  threshold           = 2
  alarm_description   = "Warning: ALB target response time exceeds 2 seconds"
  dimensions = {
    LoadBalancer = aws_lb.application_load_balancer.arn_suffix
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

# CloudWatch Metrics and Alarms for DynamoDB
resource "aws_cloudwatch_metric_alarm" "dynamodb_read_capacity" {
  alarm_name          = "${var.project_name}-${var.environment}-dynamodb-read-capacity-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "ConsumedReadCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = 300
  statistic           = "Sum"
  threshold           = 6000
  alarm_description   = "Warning: DynamoDB read capacity consumption is high"
  dimensions = {
    TableName = aws_dynamodb_table.recipes.name
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "dynamodb_write_capacity" {
  alarm_name          = "${var.project_name}-${var.environment}-dynamodb-write-capacity-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "ConsumedWriteCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = 300
  statistic           = "Sum"
  threshold           = 3000
  alarm_description   = "Warning: DynamoDB write capacity consumption is high"
  dimensions = {
    TableName = aws_dynamodb_table.recipes.name
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "dynamodb_throttled_requests" {
  alarm_name          = "${var.project_name}-${var.environment}-dynamodb-throttled-requests"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "ThrottledRequests"
  namespace           = "AWS/DynamoDB"
  period              = 300
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "Critical: DynamoDB requests are being throttled"
  dimensions = {
    TableName = aws_dynamodb_table.recipes.name
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

# CloudWatch Metrics and Alarms for CloudFront
resource "aws_cloudwatch_metric_alarm" "cloudfront_4xx_errors" {
  alarm_name          = "${var.project_name}-${var.environment}-cloudfront-4xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "4xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = 300
  statistic           = "Average"
  threshold           = 0
  alarm_description   = "Warning: CloudFront 4XX error rate exceeds 5%"
  dimensions = {
    DistributionId = aws_cloudfront_distribution.frontend.id
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "cloudfront_5xx_errors" {
  alarm_name          = "${var.project_name}-${var.environment}-cloudfront-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "5xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = 300
  statistic           = "Average"
  threshold           = 5
  alarm_description   = "Critical: CloudFront 5XX error rate exceeds 5%"
  dimensions = {
    DistributionId = aws_cloudfront_distribution.frontend.id
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

# CloudWatch Metrics and Alarms for S3
resource "aws_cloudwatch_metric_alarm" "s3_4xx_errors" {
  alarm_name          = "${var.project_name}-${var.environment}-s3-4xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "4xxErrors"
  namespace           = "AWS/S3"
  period              = 300
  statistic           = "Sum"
  threshold           = 100
  alarm_description   = "Warning: S3 bucket receiving high number of 4XX errors"
  dimensions = {
    BucketName = aws_s3_bucket.frontend.bucket
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "s3_5xx_errors" {
  alarm_name          = "${var.project_name}-${var.environment}-s3-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "5xxErrors"
  namespace           = "AWS/S3"
  period              = 300
  statistic           = "Sum"
  threshold           = 50
  alarm_description   = "Critical: S3 bucket receiving high number of 5XX errors"
  dimensions = {
    BucketName = aws_s3_bucket.frontend.bucket
  }

  alarm_actions = ["${aws_sns_topic.alerts.arn}"]
}