variable "name" {
    type = string
    default = "locals"
  
}

variable "environment" {
    type = string
    default = "dev"

}

# variable "instance_name" {
#     type = string
#     default = "${var.name}-${var.environment}"  #this will not work because we cannot use variable inside variable, we have to use local for this
# }

variable "ec2_tags" {
    default = {
        name = "locals-demo"
        environment = "prod"

    }
  
}

variable "sg_tags" {
    default = {
        name = "localssg-demo"
    }
  
}