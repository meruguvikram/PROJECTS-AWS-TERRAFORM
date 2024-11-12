# vpc variables
variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "vpc cidr block"
  type        = string
}

variable "public_subnet_az1_cidr" {
  default     = "10.0.0.0/24"
  description = "public subnet az1 cidr block"
  type        = string
}

variable "public_subnet_az2_cidr" {
  default     = "10.0.1.0/24"
  description = "public subnet az2 cidr block"
  type        = string
}

variable "private_app_subnet_az1_cidr" {
  default     = "10.0.2.0/24"
  description = "private app subnet az1 cidr block"
  type        = string
}

variable "private_app_subnet_az2_cidr" {
  default     = "10.0.3.0/24"
  description = "private app subnet az2 cidr block"
  type        = string
}

# alb variable
variable "ssl_certificate_arn" {
  default     = "paste your ssl certificate here"
  description = "ssl certificate arn"
  type        = string
}

# asg variables
variable "launch_template_name" {
  default     = "dev-launch-template"
  description = "name of the launch template"
  type        = string
}

variable "instance_type" {
  default     = "t3.micro"
  description = "instance class"
  type        = string
}

# variable github repository
variable "github_repository" {
  default     = "https://github.com/PacktPublishing/AWS-Cloud-Projects.git"
  description = "url of the git hub repository"
  type        = string
}

# route53 variables
variable "domain_name" {
  default     = "add your domain name"
  description = "domain name"
  type        = string
}

variable "record_name" {
  default     = "choose a record name"
  description = "sub domain name"
  type        = string
}