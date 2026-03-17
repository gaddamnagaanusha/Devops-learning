module "ec2" {  
    source = "../terraform-aws-instance"
    environment = "dev"
    project = "roboshop"
    sg_ids = ["sg-085cf1fdfcefdb4c0"]
    ami_id = "ami-0220d79f3f480ecf5"
    instance_type = "t3.large"
    tags = {
        name = "roboshop-dev-catalogue"
    }
} 