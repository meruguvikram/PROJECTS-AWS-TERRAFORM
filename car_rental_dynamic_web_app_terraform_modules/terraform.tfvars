# vpc variables
region                       = "eu-west-2"
project_name                 = "rentzone"
environment                  = "dev"
vpc_cidr                     = "10.0.0.0/16"
public_subnet_az1_cidr       = "10.0.0.0/24"
public_subnet_az2_cidr       = "10.1.0.0/24"
private_app_subnet_az1_cidr  = "10.2.0.0/24"
private_app_subnet_az2_cidr  = "10.3.0.0/24"
private_data_subnet_az1_cidr = "10.4.0.0/24"
private_data_subnet_az2_cidr = "10.5.0.0/24"

# security group variables
ssh_ip = "2.120.140.109/32" # your IP

# rds variables
database_identifier     = "dev-rds-db"
database_engine         = "mysql"
engine_version          = "8.0.36"
database_instance_class = "db.t3.medium"
db_master_username      = "admin1982"
db_master_password      = "nimda1982"
database_name           = "applicationdb"
parameter_groupname     = "dev-para-group"

# acm variables
domain_name       = "cloudspace-consulting.com"
alternative_names = "*.cloudspace-consulting.com"

# alb variables
target_type = "ip"

# s3 variables
env_file_bucket_name = "ecs-env-file-bucket-st"
env_file_name        = "rentzone.env"

# ecs variables
architecture    = "X86_64" # "ARM64" for mac users
container_image = "uri of the docker image"
# copy the uri of the docker image we pushed into our ecr repository
# go to aws ecr; select your repository; click latest or whatever tag you have; copy URI

# route53 variables
record_name = "www"