# environment variables
variable "region" {}
variable "project_name" {}
variable "environment" {}

# vpc variables
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}

# security group variables
variable "ssh_ip" {}

# rds variables
variable "database_identifier" {}
variable "database_engine" {}
variable "engine_version" {}
variable "database_instance_class" {}
variable "db_master_username" {}
variable "db_master_password" {}
variable "database_name" {}
variable "parameter_groupname" {}

# acm variables
variable "domain_name" {}
variable "alternative_names" {}

# alb variables
variable "target_type" {}

# s3 variables
variable "env_file_bucket_name" {}
variable "env_file_name" {}

# ecs variables
variable "architecture" {}
variable "container_image" {}

# route53 variables
variable "record_name" {}