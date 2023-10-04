# terraform script to provide IAM rules on EC2 instance
provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

resource "aws_security_group" "backend_security_group" {
  name        = "BackendSecurityGroup"
  description = "Security group for the backend EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 10
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_iam_instance_profile" "backend_iam_profile" {
  name = "BackendInstanceProfile"

  role {
    name = "BackendRole"
  }
}

resource "aws_iam_role" "backend_role" {
  name               = "BackendRole"
  assume_role_policy = <<EOF
{
  "Version": "2023-07-19",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

output "security_group_id" {
  value = aws_security_group.backend_security_group.id
}

output "iam_role_name" {
  value = aws_iam_role.backend_role.name
}