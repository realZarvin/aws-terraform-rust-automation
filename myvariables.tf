# Variable definitions with default values




variable "aws_region" {
  description = "The AWS region where resources will be created"
  default     = "us-west-2"
}


variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}


variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}


variable "availability_zone" {
  description = "AWS availability zone"
  default     = "us-west-2a"
}.

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0abcdef1234567890"
}


variable "ec2_instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}
