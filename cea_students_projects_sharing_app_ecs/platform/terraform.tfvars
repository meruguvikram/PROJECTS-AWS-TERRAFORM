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

# ecs variable
image              = "<aws acc id>.dkr.ecr.<your region>.amazonaws.com/<ecr repo name>:<tag>"
ecr_repository_arn = "arn:aws:ecr:<your region>:<aws acc id>:repository/<ecr repo name>"

# route53 variables
domain_name       = "<your domain name>"
alternative_names = "*.<your domain name>"
record_name       = "www"

# SNS variables
email = "<your email>"