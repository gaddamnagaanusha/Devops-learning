resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = local.vpc_final_tags
  }


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id  #vpc associated with this internet gateway

  tags = {
    Name = local.igw_final_tags
  }
}