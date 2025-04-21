provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0846b753e2af0da6e"  # Change to your region's AMI
  instance_type = "t4g.nano"
  key_name      = "Terraform-On-Github"  # Only the key name is required
  associate_public_ip_address = true  # THIS is required
  tags = {
    Name = "Soln-Arch"
  }
}
