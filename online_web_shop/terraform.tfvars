# environment variables
region       = "eu-south-2"
project_name = "cloud-consulting"
environment  = "dev"

# vpc variables
vpc_cidr                     = "10.0.0.0/16"
public_subnet_az1_cidr       = "10.0.0.0/24"
public_subnet_az2_cidr       = "10.0.1.0/24"
private_app_subnet_az1_cidr  = "10.0.2.0/24"
private_app_subnet_az2_cidr  = "10.0.3.0/24"
private_data_subnet_az1_cidr = "10.0.4.0/24"
private_data_subnet_az2_cidr = "10.0.5.0/24"

# ASG variables
asg_min              = 1
asg_max              = 4
asg_des_cap          = 2
lt_asg_ami           = "ami-0d27757cc8327f88f"
lt_asg_instance_type = "t3.micro"

# rds variables
db_engine                    = "mysql"
db_engine_version            = "8.0.36"
multi_az_deployment          = "true"
database_instance_identifier = "app-db"
database_username            = "admin1982"
database_password            = "nimda1982"
database_name                = "cloudconsultingdb"
database_instance_class      = "db.t3.medium"
publicly_accessible          = "false"

# acm variables
domain_name       = "cloudspace-consulting.com" # paste your domain name
alternative_names = "*.cloudspace-consulting.com"

# route-53 variables
record_name = "www"


