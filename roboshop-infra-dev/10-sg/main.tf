module "vpc" {
    source = "../../terraform-aws-sg"
    project = "roboshop"
    environment = "dev"
    sg_name =  "mongodb"
    vpc_id = module.vpc.vpc_id

}