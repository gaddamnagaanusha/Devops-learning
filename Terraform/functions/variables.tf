variable "common_tags" {
    default = {
        project = "roboshop"
        environment = "dev"
        terraform = "true"
    }
  
}

variable "ec2_tags" {
    default = {
        name = "functions-demo"
        environment = "prod"
    }
  
}

variable "sg_tags" {
    default = {
        name = "functions-demo"
    }
  
}