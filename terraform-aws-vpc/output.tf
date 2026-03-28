output "availability_zones_names" {
  # Refers to the 'names' attribute of the 'available' data source instance
  value = data.aws_availability_zones.available.names
  description = "The list of available Availability Zone names in the current region"
}


output "vpc_id" {

  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  value = aws_subnet.database[*].id
}