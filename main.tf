terraform {
	backend "s3" {
		bucket = "terraform-bucket-new"
		key = "terraform.tfstate"
		region = "us-east-2"
	}
}

resource "aws_instance" "hello-world" {

 ami = "ami-0a313d6098716f372" 
 instance_type = "t2.micro"
 vpc_security_group_ids = "vpc-0167570d158057e01"
 key_name = "terraform"
 tags = {
	 Name = "Hello world"
 }

}
