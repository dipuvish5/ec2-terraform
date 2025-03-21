provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0846b753e2af0da6e"  # Change to your region's AMI
  instance_type = "t4g.nano"
  key_name      = "your-key-pair"          # Replace with your key pair
  tags = {
    Name = "Soln-Arch"
  }
}

resource "aws_eip" "my_eip" {
  domain   = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.my_instance.id
  allocation_id = aws_eip.my_eip.id
}

resource "aws_route53_record" "my_record" {
  zone_id = "Z0358020WBTRB1CMQU2V"   # Replace with your Route 53 Hosted Zone ID
  name    = "api-java.deepakvishwakarma.com"      # Replace with your domain
  type    = "A"
  ttl     = 60
  records = [aws_eip.my_eip.public_ip]
}
