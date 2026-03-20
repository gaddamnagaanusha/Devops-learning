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

resource "aws_route" "public_peering" {
  count = var.is_peering_required ? 1 : 0  
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_perring_connection.id
}

resource "aws_route" "private_peering" {
  count = var.is_peering_required ? 1 : 0  
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_perring_connection.id
}

resource "aws_route" "database_peering" {
  count = var.is_peering_required ? 1 : 0  
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_perring_connection.id
}

resource "aws_route" "defult_peering" {
  count = var.is_peering_required ? 1 : 0  
  route_table_id            = data.aws_route_table.default_route_table.id
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_perring_connection.id
}

