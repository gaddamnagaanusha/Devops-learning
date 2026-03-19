locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    terraform   = "true"
  }

  vpc_final_tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}"  #this is for giving the name to our vpc, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our vpc along with the common tags
        },

        var.vpc_tags
    )

    igw_final_tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}"  #this is for giving the name to our internet gateway, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our internet gateway along with the common tags
        },

        var.igw_tags
    )

public_availability_zones_names = slice(data.aws_availability_zones.available.names, 0, 2)
     # this is for getting the names of the availability zones in the current region, we are using the aws_availability_zones data source to get the availability zones and then we are using the names attribute to get the names of the availability zones and assigning it to the local variable public_availability_zones_names, so that we can use this variable in other terraform file by calling this module.
public_subnet_tags = merge(
    local.common_tags,
     #roboshop-dev-public-east-1a,reboshop-dev-public-east-1b
    {
        Name = "${var.project}-${var.environment}-public-${local.public_availability_zones_names[0]}"  #this is for giving the name to our public subnets, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our public subnets along with the common tags
    }
)




private_availability_zones_names = slice(data.aws_availability_zones.available.names, 2, 4)
     # this is for getting the names of the availability zones in the current region, we are using the aws_availability_zones data source to get the availability zones and then we are using the names attribute to get the names of the availability zones and assigning it to the local variable private_availability_zones_names, so that we can use this variable in other terraform file by calling this module.
private_subnet_tags = merge(
    local.common_tags,
     #roboshop-dev-private-east-1a,reboshop-dev-private-east-1b
    {
        Name = "${var.project}-${var.environment}-private-${local.private_availability_zones_names[2]}"  #this is for giving the name to our private subnets, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our private subnets along with the common tags
    }
)

}