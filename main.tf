terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-south-1"
}

resource "aws_key_pair" "jenkins-key" {
  key_name   = "jenkins-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCfVDqZN7317e5jNEKsxAOSdrlXBwxUHfSje/Voi1xT+s9t3b1QOUZFgG91GgCQMAXfxqI8YvRhBS3L1kuT1zEZBfZ5HKMMQsjfLp1RhnK5DxqN1JlHWbPcvQtt6FEFr0UsAGGeD+1cct6K5Fk+UWfcCLlZvL3XGf+xa1NN2tPf7FTtqyY8pzX+GjXw98J2FhhvybLFvgJ71EX9r1SNIKPE0A4LUnkj7/LsLEyc77G3joM1IMLfnF8rCMOaphOyqjLWUQUgP0yfhEwCU0uRp4TYfqBJ10gEcq+1oTWE58yBAUIlDjJtBt4kvaa0bLcK/MGFRRLzebL16gELAuiv8os8ND/w/N/gNT44riJ/a6iDodxOeSmYaACMVpNS2Hsoi088/LYQ9zts41XQmdwPT9e3XC3tdXgCh/OwrTnKeUeDwALHpEFoQuWhYPKqK9pU4pnpCI0S22OpvPfcEdLZxtZz+oRhpDL+9f/yU3okvy0mtRzfSHkMFdZNX312usgxFpyuhJCUYmbuBVjI2hgGCWyRjhBqUZc6r9yNbw9eJlaAYM/PpLyYYD5fMRD0JamoAVcrV6S81A1yTlw6RfuB49txZHiDuD/YHshgoACMb50KxTlDt83CXjv8oD1LFA+Zz87nVX8+npJOxHzqDGK5E9FpOnA9V9d6Bqs0x5rZu8eYyw== jenkins@ci-server"
}

resource "aws_instance" "example_server" {
  ami           = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.micro"
  key_name = aws_key_pair.jenkins-key.key_name
  tags = {
    Name = "webserver"
  }
}

output "ec2_ip" {
  value = "${aws_instance.example_server.public_ip}"
}
