# Create a database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name       = "${var.project_name}-${var.environment}-database-subnets"
  description = "subnets for database instance"

  subnet_ids = [
    var.private_data_subnet_az1.id,
    var.private_data_subnet_az2.id
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-database-subnets"
  }
}

# Create the RDS instance
resource "aws_db_instance" "dev_rds_db" {
  identifier              = var.database_identifier
  engine                  = var.database_engine
  engine_version          = var.engine_version
  instance_class          = var.database_instance_class
  skip_final_snapshot     = true
  allocated_storage       = 20
  max_allocated_storage   = 100
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids  = [var.database_security_group_id]
  multi_az                = true 
  username                = var.db_master_username
  password                = var.db_master_password
  db_name                 = var.database_name
  storage_encrypted       = true
  backup_retention_period = 7
  parameter_group_name    = var.parameter_groupname 

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "dev-rds-db"
  }
}
