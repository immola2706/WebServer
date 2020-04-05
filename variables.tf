variable "region" {
	description = " it will define the AWS region "
	default	= "us-east-2"
}
variable "http_port" {
	description = " http service listen on ths port "
	default = "80"
}

variable "ssh_port" {
	description = "ssh request to server  "
	default = "22"
}
variable "instance_type" {
	description = "AWS ec2 instance type"
	default = "t2.micro"
}

variable "ami" {
description = "amazon machine image"
default = "ami-0a313d6098716f372"
}
