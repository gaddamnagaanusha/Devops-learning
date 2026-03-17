module "ec2"{    #this is indicating that we are creating a module for ec2 instance, we can give any name to this module
    source = "/terraform-aws-instance"
}