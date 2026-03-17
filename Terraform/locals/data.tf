data "aws_ami" "devops" {
   most_recent      = true
   owners           = ["self"]

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