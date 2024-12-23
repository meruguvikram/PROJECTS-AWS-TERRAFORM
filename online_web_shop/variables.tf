# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "environment" {
  description = "environment"
  type        = string
}

# vpc variables
variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string
}

variable "public_subnet_az1_cidr" {
  description = "public subnet az1 cidr block"
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "public subnet az2 cidr block"
  type        = string
}

variable "private_app_subnet_az1_cidr" {
  description = "private app subnet az1 cidr block"
  type        = string
}

variable "private_app_subnet_az2_cidr" {
  description = "private app subnet az2 cidr block"
  type        = string
}

variable "private_data_subnet_az1_cidr" {
  description = "private data subnet az1 cidr block"
  type        = string
}

variable "private_data_subnet_az2_cidr" {
  description = "private data subnet az2 cidr block"
  type        = string
}

# ASG variables
variable "asg_min" {
  description = "ASG minimum size"
  type        = string
}

variable "asg_max" {
  description = "ASG maximum size"
  type        = string
}

variable "asg_des_cap" {
  description = "ASG desired capacity"
  type        = string
}

variable "lt_asg_ami" {
  description = "Launch template AMI"
  type        = string
}

variable "lt_asg_instance_type" {
  description = "Launch template instance type"
  type        = string
}

# rds variables
variable "db_engine" {
  description = "database engine"
  type        = string
}

variable "db_engine_version" {
  description = "database engine version"
  type        = string
}

variable "multi_az_deployment" {
  description = "create a standby db instance"
  type        = bool
}

variable "database_instance_identifier" {
  description = "database instance identifier"
  type        = string
}

variable "database_username" {
  description = "database username"
  type        = string
}

variable "database_password" {
  description = "database username"
  type        = string
}

variable "database_name" {
  description = "database name"
  type        = string
}

variable "database_instance_class" {
  description = "database instance type"
  type        = string
}

variable "publicly_accessible" {
  description = "controls if instance is publicly accessible"
  type        = bool
}

# ACM variables
# acm variables
variable "domain_name" {
  description = "domain name"
  type        = string
}

variable "alternative_names" {
  description = "sub domain name"
  type        = string
}

# route-53 variables
variable "record_name" {
  description = "sub domain name"
  type        = string
}