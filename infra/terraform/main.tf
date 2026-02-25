resource "aws_instance" "guardian_instance" {
  ami           = "ami-0f5ee92e2d63afc18" # Amazon Linux 2 (Mumbai region)
  instance_type = var.instance_type

  tags = {
    Name = "Terraform-Guardian-Instance"
  }
}