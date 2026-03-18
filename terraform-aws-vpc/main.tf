resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = local.vpc_final_tags
  }


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id  #vpc associated with this internet gateway

  tags = local.igw_final_tags
}

# resource "aws_subnet" "public" {
#   count = length(var.public_subnet_cidrs) #this is for creating multiple public subnets based on the number of cidr blocks we have in the public_subnet_cidrs variable, we are using count meta argument to create multiple resources based on the number of cidr blocks we have in the public_subnet_cidrs variable
#   vpc_id     = aws_vpc.main.id
#   cidr_block = var.public_subnet_cidrs[count.index] #this is for getting the cidr block for each subnet from the public_subnet_cidrs variable based on the index of the count, we are using count.index to get the index of the current resource being created, so that we can get the corresponding cidr block from the public_subnet_cidrs variable
#   tags = {
#     Name = "Main"
#   }
# }