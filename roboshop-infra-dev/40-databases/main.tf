resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_ids
  vpc_security_group_ids = [local.mongodb_sg_id]

  root_block_device {  #increasing root block device configuration 
     volume_size = 50
     volume_type = "gp3"
     tags = merge(
    {
      Name = "${var.project}-${var.environment}-bastion"
    },
    local.common_tags,
  )
  }

  


  tags = merge(
    {
      Name = "${var.project}-${var.environment}-mongodb"
    },
    local.common_tags,
  )

}

resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }

  provisioner "file" {
    source      = "bootstrap.sh" # Local file path
    destination = "/tmp/bootstrap.sh"    # Destination path on the remote machine
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
    ]
  }
}
