output "public_ip" {
    value = "${aws_instance.Terraform-default.public_ip}"
}
