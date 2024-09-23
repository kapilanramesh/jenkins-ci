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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzYCgKLupE3Kd+XeqDKy6Lhb7ZA3c66MWA6sATrteiOZcjfpZ154okz2BLLkKA24oGLWdlxdHEUPvwrLLyn7yd756CdKO7dp2m9HYGJtynkNM67WJscrdHTPACedl8kWuhSd7xne13UPS+VX2SsAKo22wwxCoBku7auwGtWHmq8d/O+ztm4O7rE2H7EwcZRDfcHjWPamz5S8kR8pOaQ5cGCY23MuipPq9UE7d1E/YpooUXa0uzxvejh17XEVRh/jA5UlB+4u9uzJrn7dnb5msG/vBwq3lyGU7QQibjKziuu96aTdp4vrhQZARdE20YGfKGeMnK0WEntIyF3gtNtGgkGJSmbeWnif76oW4wPTDGiOBXeQM27Fnn2E4/LOhGDTQp+wZU1aZc+GTR6+CgnPBwrlKioF8iGa/s6+vrWZ/m/qO0DFlOPGyWCCCk2rFhxxMAsyVIAu4iz7wP0Rd9DuTrz6to9HrrXkzzlt2M1pZgI9/wa8QSJF1uzQED9lHCqcar3MPu1DgS4IOjlXGslGZS/qkisua1ib2/SoMtUH4i+zXMyuq4ZqBFSuHDQY1bsuFUnY+DBQ8jOGwtJ7VN1SRCgAt/eUBGsjjaAGzfag/i1gypX3QmMENNm7D5WTDOev6RzSQyzFl/WE9Fn85OEhGqL7v75FX4hyM3GyDx5kziBQ== ubuntu@ci-server"
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
