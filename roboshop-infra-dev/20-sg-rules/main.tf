resource "aws_security_group_rule" "bastion_internet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
  cidr_blocks       = [local.my_ip]

  #which Sg you are creating this rule
  security_group_id = local.bastion_sg_id

}

resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
   
   #where traffic is coming from 
  source_security_group_id = local.bastion_sg_id 

  security_group_id = local.mongodb_sg_id
}