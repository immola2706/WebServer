terraform {
	backend "s3" {
		bucket = "terraform-bucket-new"
		key = "terraform.tfstate"
		region = "us-east-2"
	}
}
// use AWS terraform provider
provider "aws" {
	region = "us-east-2"
}

// Create EC2 Instance
resource "aws_instance" "default" {
	ami = "var.ami"
	count = 2
	key_name = "Terraform"
	vpc_security_group_ids = ["${aws_security_group.default.id}"]
	instance_type = "var.instance_type"
	tags = {
	Name = "Terraform-default"  
}
}
// Create Security Group for EC2
resource "aws_security_group" "default" {
	name = "Terraform-default-sg"

	ingress {
		from_port = ["${var.http_port}"]
		to_port = ["${var.http_port}"]
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		}
	
	ingress {
		from_port = ["${var.ssh_port}"]
		to_port = ["${var.ssh_port}"]
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		} 
}






