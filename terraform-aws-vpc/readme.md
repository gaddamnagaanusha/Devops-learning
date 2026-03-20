# Terraform aws vpc setup

  ## This module creates following resources

* create VPC
* create IGW and attach to VPC
* create subnets -> public private database
* route tables - > public private database
* associatons and routes
* EIP
* NAT gateway  -> to provide engress access to resources in private subnets

