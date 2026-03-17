resource "aws_instance" "example" {
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

   #self is a special variable which is used to refer the current resource
   #public_ip is the attribute of aws_instance resource which will give the public ip of the instance
   #we are using local-exec provisioner to execute a command on the local machine after the instance is created. The command is echoing the public ip of the instance and saving it to a file called inventory.ini
   #we can use this inventory.ini file to run ansible playbooks on the instance using ansible ad-hoc commands or ansible playbooks
   #we can also use this inventory.ini file to run ansible playbooks on the instance
  provisioner "local-exec" {
    command = "echo '${self.public_ip}' > inventory.ini"
    
  }

  tags = {
    Name = "provisioners-demo"
    Project = "roboshop"
  }
}

resource "aws_security_group" "allow_tls" {  #this is for terraform
  name        = "allow-all-terraform" # this is for AWS account
  description = "Allow TLS inbound traffic and all outbound traffic"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-all-terraform"
  }
}