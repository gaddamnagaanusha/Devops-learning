module "ec2" {  
    source = "../terraform-aws-instance"
    environment =var.env
    project = var.project_name
    sg_ids = var.sg_ids
    ami_id = data.aws_ami.devops.id
    tags = {
        Name = "${var.project_name}-${var.env}-${var.component}"
        component = var.component
    }
} 