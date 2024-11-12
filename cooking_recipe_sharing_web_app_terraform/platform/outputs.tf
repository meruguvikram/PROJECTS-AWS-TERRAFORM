output "cloudfront_distribution_url" {
  description = "URL of the CloudFront distribution to Access our frontend"
  value       = aws_cloudfront_distribution.frontend.domain_name
}

output "cloudfront_distribution_id" {
  description = "The CloudFront Distribution ID"
  value       = aws_cloudfront_distribution.frontend.id
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.application_load_balancer.dns_name
}