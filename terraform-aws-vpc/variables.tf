variable "project" {
    type = string
  
}

variable "environment" {
   type = string

}


variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
  
}

variable "vpc_tags" {
    type = map
    default = {}  #this is optional variable, if we are not passing the value of this variable when we are calling this module in other terraform file, then it will take the default value of empty map
  
}

variable "igw_tags" {
    type = map
    default = {}  #this is optional variable, if we are not passing the value of this variable when we are calling this module in other terraform file, then it will take the default value of empty map
  
}

variable "public_subnet_cidrs" {
    type = list
    default = ["10.0.1.0/24", "10.0.2.0/24"]
  
}

variable "public_subnet_tags" {
    default = {}
    type = map
}

variable "private_subnet_cidrs" {
    type = list
    default = ["10.0.11.0/24", "10.0.12.0/24"]
  
}

variable "private_subnet_tags" {
    default = {}
    type = map
}

variable "database_subnet_cidrs" {
    type = list
    default = ["10.0.21.0/24", "10.0.22.0/24"]
  
}

variable "database_subnet_tags" {
    default = {}
    type = map
}

variable "public_route_table_tags"{
    default = {}
    type = map
}

variable "private_route_table_tags"{
    default = {}
    type = map
}

variable "database_route_table_tags"{
    default = {}
    type = map
}

variable "eip_tags" {
    default = {}
    type = map
  
}

variable "nat_gateway_tags" {
    default = {}
    type = map
  
}