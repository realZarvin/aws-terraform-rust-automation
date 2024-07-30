

# Defining the AWS provider and specifying the region
provider "aws" {
  region = var.aws_region
}


# Creating a VPC with a CIDR block
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "my_vpc"
  }
}


# Creating a public subnet within the VPC
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "my_subnet"
  }
}


# Launching an EC2 instance within the subnet
resource "aws_instance" "my_instance" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.my_subnet.id
  tags = {
    Name = "my_instance"
  }
}


# Creating an RDS instance
resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  name                 = "mydatabase"
  username             = "admin"
  password             = "password123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  tags = {
    Name = "my_rds"
  }
}


# Outputs to display after Terraform apply
output "vpc_id" {
  value = aws_vpc.my_vpc.id
}


output "subnet_id" {
  value = aws_subnet.my_subnet.id
}


output "instance_id" {
  value = aws_instance.my_instance.id
}


output "rds_endpoint" {
  value = aws_db_instance.my_rds.endpoint
}
