resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr # This is the CIDR block for the VPC
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = local.vpc_final_tags
  }


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id  #vpc associated with this internet gateway

  tags = local.igw_final_tags
}

#public subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs) #this is for creating multiple public subnets based on the number of cidr blocks we have in the public_subnet_cidrs variable, we are using count meta argument to create multiple resources based on the number of cidr blocks we have in the public_subnet_cidrs variable
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index] #this is for getting the cidr block for each subnet from the public_subnet_cidrs variable based on the index of the count
  availability_zone = local.availability_zones_names[count.index]
  map_public_ip_on_launch = true 

  tags = merge(
    local.common_tags,
     #roboshop-dev-public-east-1a,reboshop-dev-public-east-1b
    {
        Name = "${var.project}-${var.environment}-public-${local.availability_zones_names[count.index]}"  #this is for giving the name to our public subnets, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our public subnets along with the common tags
    },
    var.public_subnet_tags

  )
}

#private subnet
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs) #this is for creating multiple public subnets based on the number of cidr blocks we have in the public_subnet_cidrs variable, we are using count meta argument to create multiple resources based on the number of cidr blocks we have in the public_subnet_cidrs variable
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index] #this is for getting the cidr block for each subnet from the public_subnet_cidrs variable based on the index of the count
  availability_zone = local.availability_zones_names[count.index]
   

  tags = merge(
    local.common_tags,
     #roboshop-dev-private-east-1a,reboshop-dev-private-east-1b
    {
        Name = "${var.project}-${var.environment}-private-${local.availability_zones_names[count.index]}"  #this is for giving the name to our private subnets, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our private subnets along with the common tags
    },
    var.private_subnet_tags
)

}


#database subnet
resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs) #this is for creating multiple public subnets based on the number of cidr blocks we have in the public_subnet_cidrs variable, we are using count meta argument to create multiple resources based on the number of cidr blocks we have in the public_subnet_cidrs variable
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index] #this is for getting the cidr block for each subnet from the public_subnet_cidrs variable based on the index of the count
  availability_zone = local.availability_zones_names[count.index]
   

  tags = merge(
    local.common_tags,
     #roboshop-dev-database-east-1a,reboshop-dev-database-east-1b
    {
        Name = "${var.project}-${var.environment}-database-${local.availability_zones_names[count.index]}"  #this is for giving the name to our database subnets, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our database subnets along with the common tags
    },
    var.database_subnet_tags
)

}