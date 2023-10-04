# terraform script to create EC2 instance
provider "aws" {
  region = "us-east-1" 
}

resource "aws_instance" "backend_instance" {
  ami           = "ami-9a12983pq2217ec2"
  instance_type = "t2.micro"               # Replace with your desired instance type
  key_name      = "ec2-instance-key-pair-name"         # Replace with your EC2 key pair name

  tags = {
    Name = "BackendInstance"
  }
}

output "instance_id" {
  value = aws_instance.backend_instance.id
}