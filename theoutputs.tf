# Outputs to show the created resource IDs and endpoints

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
