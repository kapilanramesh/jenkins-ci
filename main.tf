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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIEgl+xz6DYJKiNu4Kazng2ZA2Pa0d16DjJq9BKOvqlKJGyb81yD/ezBfrnzpdUYybrWdJctqEzwrK0D8Z8mVY+GalM75PD/e1lkDMbU1zJWJShIom7wckOaJAQRV+nGET3NDKAGZzJ10/uxmQ0cMxZsF3PVHF+aOy2nBKKdKKqOA3SW+uswSPPkGI3OTYulpi9+2TnpdQEDApKsufKMudrIwyXiJRmQmwc6x9une1jjUP3UPFlHGTl4nZ/ofhQETRypGDrk1kGVnETpeqnOQJs/THTqyRcnWfohlFiDf/5Rj5Zu1MjLQOBUmlEEI03nbmRSLpFmdMe6zcjbeZw+9SpFxFbLjBz3kLkzsjjiHxqQ8ugtBvbVfVUcorCoC5j/I7Y9XeAWCDyxPvPtDexnodAn/1+wmyNA3muEIKb0LCMX/VgUrYhOuNx4fgFhC0qDmEbNUTu4KvJqR+gAgWmYRDxeURFVwSHBLf8KEP8GpNqKwCyHLEk6EzWmvhIF4Ao4F1Y8h8JhgK11e0iRokcjJ8fyAIGI8BKmS3xej/+Dwt1VaOeSD/WaV5t5j4jpCike/xcR2v9MK3FR+MlQd6pzLiJnu+du1ogtN0WgAnTTui0Ubfw8qfxtQ4E7bCzSZykiSQrBJx0spN6hPsT1HI3c6cu8CWRLu8qgw1uRGq5bZ9dw== jenkins@ci-server"
}

resource "aws_instance" "example_server" {
  ami           = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.micro"
  key_name = aws_key_pair.jenkins-key.key_name
  tags = {
    Name = "webserver1"
  }
}

output "ec2_ip" {
  value = "${aws_instance.example_server.public_ip}"
}
