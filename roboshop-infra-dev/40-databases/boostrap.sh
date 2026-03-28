#!/bin/bash

dnf install ansible -y

cd /home/ec2-user

git clone https://github.com/gaddamnagaanusha/Devops-learning//ansible-roboshop-roles-tf.git

cd ansible-roboshop-roles-tf

ansible-playbook -e component=mongodb roboshop.yaml