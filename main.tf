terraform {
	backend "s3" {
		bucket = "terraform-bucket-new"
		key = "terraform.tfstate"
		region = "us-east-1"
	}
}
// use AWS terraform provider
provider "aws" {
	region = "us-east-1"
}

// Create EC2 Instance
resource "aws_instance" "Terraform" {
	ami = "ami-09d95fab7fff3776c"
	count = "3"
	key_name = "AWSEKS"
	vpc_security_group_ids = ["${aws_security_group.Terraform.id}"]
	instance_type = "t2.micro"
	tags = {
	Name = "Terraform-default"  
}
}
// Create Security Group for EC2
resource "aws_security_group" "Webserver-sg" {
	name = "Terraform-default-sg"

	ingress {
		from_port = "80"
		to_port = "80"
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		}
	
	ingress {
		from_port = "22"
		to_port = "22"
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		} 
}






