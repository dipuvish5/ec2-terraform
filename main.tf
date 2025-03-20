provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0abcdef1234567890"  # Change to your region's AMI
  instance_type = "t2.micro"
  key_name      = "your-key-pair"          # Replace with your key pair
  tags = {
    Name = "Scheduled-EC2"
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
  zone_id = "Z123456789ABCDEFG"   # Replace with your Route 53 Hosted Zone ID
  name    = "yourdomain.com"      # Replace with your domain
  type    = "A"
  ttl     = 300
  records = [aws_eip.my_eip.public_ip]
}
