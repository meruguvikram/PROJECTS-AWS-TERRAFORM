# environment variables
region       = "<your region>"
project_name = "cea-projects"
environment  = "dev"

# vpc variables
vpc_cidr                    = "10.0.0.0/16"
public_subnet_az1_cidr      = "10.0.0.0/24"
public_subnet_az2_cidr      = "10.0.1.0/24"
private_app_subnet_az1_cidr = "10.0.2.0/24"
private_app_subnet_az2_cidr = "10.0.3.0/24"

# asg variable
instance_type = "t3.micro"

# route53 variables
domain_name       = "<your domain>"
alternative_names = "*.<your domain>"
record_name       = "www"

# SNS variables
email = "<your email>"