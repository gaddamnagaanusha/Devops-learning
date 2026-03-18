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