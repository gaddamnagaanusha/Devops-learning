variable "ami_id" { #Here Ami_id is mandatory variable, we have to pass the value of this variable when we are calling this module in other terraform file. This is for making our code reusable and modular. We can use this module for creating multiple ec2 instances with different ami_id and instance_type by just passing the values of these variables.
    type = string
    
}

variable "instance_type" { 
    type = string
    default = "t3.micro" # this is for default value, if we are not passing the value of this variable when we are calling this module in other terraform file, then it will take the default value of t3.micro
  
}