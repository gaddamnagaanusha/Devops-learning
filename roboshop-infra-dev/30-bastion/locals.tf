locals {
    common_tags = {
        Project     = var.project
        Environment = var.environment
        terraform   = "true"
    }
  ami_id = data.aws_ami.bastion.id
  #public subnet in 1a AZ
  public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
}

  