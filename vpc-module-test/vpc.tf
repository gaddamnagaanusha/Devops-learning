module "vpc" {
    # source = "../terraform-aws-vpc"
    source = "git::https://github.com/gaddamnagaanusha/Devops-learning/tree/Main/terraform-aws-vpc?ref=main"
    project = "roboshop"
    environment = "dev"

}