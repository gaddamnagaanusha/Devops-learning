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

#public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
     #roboshop-dev-public
    {
        Name = "${var.project}-${var.environment}-public" 
     }, #this is for giving the name to our public route table, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our public route table along with the common tags
   
    var.public_route_table_tags
)

}  

#private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
     #roboshop-dev-private
    {
        Name = "${var.project}-${var.environment}-private" 
     }, #this is for giving the name to our private route table, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our private route table along with the common tags
   
    var.private_route_table_tags
)

}  

#database route table
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
     #roboshop-dev-database
    {
        Name = "${var.project}-${var.environment}-database" 
     }, #this is for giving the name to our database route table, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our database route table along with the common tags
   
    var.database_route_table_tags
)

}  

resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id =  aws_internet_gateway.gw.id
}

#elastic ip for nat gateway

resource "aws_eip" "nat" {
  domain   = "vpc"
    tags = merge(
        local.common_tags,
         #roboshop-dev-nat
        {
            Name = "${var.project}-${var.environment}-nat" 
         }, #this is for giving the name to our nat gateway elastic ip, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our nat gateway elastic ip along with the common tags
     
        var.eip_tags
)
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id   # here we creating this is us-east-1a AZ

  tags = merge(
        local.common_tags,
        
        {
            Name = "${var.project}-${var.environment}"
        },     
        var.nat_gateway_tags
)
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id =  aws_nat_gateway.nat_gateway.id
}

resource "aws_route" "database" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id =  aws_nat_gateway.nat_gateway.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs) #this is for associating multiple public subnets with the public route table based on the number of cidr blocks we have in the public_subnet_cidrs variable, we are using count meta argument to create multiple resources based on the number of cidr blocks we have in the public_subnet_cidrs variable
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs) #this is for associating multiple private subnets with the private route table based on the number of cidr blocks we have in the private_subnet_cidrs variable, we are using count meta argument to create multiple resources based on the number of cidr blocks we have in the private_subnet_cidrs variable
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrs) #this is for associating multiple database subnets with the database route table based on the number of cidr blocks we have in the database_subnet_cidrs variable, we are using count meta argument to create multiple resources based on the number of cidr blocks we have in the database_subnet_cidrs variable
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}


resource "aws_vpc_peering_connection" "default" {
  count = var.is_peering_required ? 1 : 0
  #acceptor
  peer_vpc_id   = data.aws_vpc.default_vpc

  #requester
  vpc_id        = aws_vpc.main.id

  auto_accept = true  #this is for automatically accepting the peering connection request, if we set this to false then we have to manually accept the peering connection request from the accepter side, but if we set this to true then the peering connection request will be automatically accepted from the accepter side.

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = merge(
      local.common_tags,
     #roboshop-dev-peering
      {
        Name = "${var.project}-${var.environment}-defult" 
       }, #this is for giving the name to our vpc peering connection, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our vpc peering connection along with the common tags
   
        var.peering_tags
)
}

