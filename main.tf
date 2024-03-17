variable "vpc_id" {
  description = "ID da VPC onde o DocumentDB será criado"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_subnet" "pixels" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Pixels-Db-Subnets"
  }
}

resource "aws_subnet" "pixelsb" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Pixels-Db-Subnets"
  }
}

resource "aws_security_group" "pixels" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  }

  tags = {
    Name = "Pixels-Db-SG"
  }
}

resource "aws_docdb_subnet_group" "pixels" {
  name       = "pixels-subnet-group"
  subnet_ids = [aws_subnet.pixels.id,aws_subnet.pixelsb.id]
}

resource "aws_docdb_cluster_instance" "pixels" {
  identifier           = "pixels-db"
  instance_class      = "db.t3.medium"
  cluster_identifier   = aws_docdb_cluster.pixels.id
}

resource "aws_docdb_cluster" "pixels" {
  db_subnet_group_name = aws_docdb_subnet_group.pixels.name
  master_password         = "XMrGrqVfew4YSDeQ"
  master_username         = "pixelsadmin"
  cluster_identifier   = "pixels-db-docdb"
  preferred_backup_window = "07:00-09:00"
  preferred_maintenance_window = "tue:10:00-tue:11:00"
  skip_final_snapshot = true
  
  vpc_security_group_ids = [aws_security_group.pixels.id]
}

resource "aws_db_subnet_group" "mysql" {
  name       = "mysql-subnet-group1"
  subnet_ids = [aws_subnet.pixels.id, aws_subnet.pixelsb.id]
}

resource "aws_db_instance" "mysql_instance1" {
  allocated_storage    = 20
  storage_type         = "gp3"
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.small"
  identifier           = "fiap-productiondb"
  username             = "admin"
  password             = "XMrGrqVfew4YSDeQ"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = false

  vpc_security_group_ids = [aws_security_group.pixels.id]
  db_subnet_group_name   = aws_db_subnet_group.mysql.id

  db_name  = "db"

  tags = {
    Name = "MyMySQLDB"
  }
}

resource "aws_db_instance" "mysql_instance2" {
  allocated_storage    = 20
  storage_type         = "gp3"
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.small"
  identifier           = "fiap-paymentdb"
  username             = "admin"
  password             = "XMrGrqVfew4YSDeQ"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = false

  vpc_security_group_ids = [aws_security_group.pixels.id]
  db_subnet_group_name   = aws_db_subnet_group.mysql.id

  db_name  = "db"

  tags = {
    Name = "MyMySQLDB"
  }
}
