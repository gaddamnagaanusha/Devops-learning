resource "aws_route53_record" "www-dev" {
  count = 6
  zone_id = var.zone_id
  name    = "${var.instances[count.index]}+${var.domain_name}"  #mongodb.sainu.online
  type    = "A"
  ttl     = 1
  records = [aws_instance.example[count.index].private_ip]
}
# roboshop.daws88s.online -> public_ip
# As part of functions
resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  # interpolation
  name    = "roboshop.${var.domain_name}" # roboshop.daws88s.online
  type    = "A"
  ttl     = 1
  records = [aws_instance.example[index(var.instances, "payment")].public_ip]
}