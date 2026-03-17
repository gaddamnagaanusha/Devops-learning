locals {
  instance_name = "${var.name}-${var.environment}"
  instance_type = "t3.micro"
  common_tags ={
    project = "roboshop"
    Environment = "dev"
    terraform = "true"
  }

  ec2_final_tags = merge(local.common_tags, var.ec2_tags)
  ami_id = data.aws_ami.devops.id

}