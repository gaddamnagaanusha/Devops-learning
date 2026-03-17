data "aws_ami" "devops" {
   most_recent      = true
   owners           = ["973714476881"] # AMI AWS account ID

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

 filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}