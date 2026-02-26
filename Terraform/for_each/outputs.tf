output "ec2_output"{
    value = aws_instance.example
    description = "description"
    depends_on = [ ]

}