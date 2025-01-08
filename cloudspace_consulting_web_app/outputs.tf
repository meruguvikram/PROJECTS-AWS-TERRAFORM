# Output ACM Certificate ARN
output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.alb_certificate.arn
}

# Output Hosted Zone ID from Route 53 hosted zone
output "route53_zone_id" {
  description = "The Hosted Zone ID for Route 53"
  value       = data.aws_route53_zone.hosted_zone.zone_id
}

# Output: Load Balancer DNS Name
output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.application_load_balancer.dns_name
}

# Output: Custom Domain URL
output "website_url" {
  value = join("", ["https://", var.record_name, ".", var.domain_name])
}
