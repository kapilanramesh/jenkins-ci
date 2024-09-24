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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCsyi0eWHaJeoAVvmqloyTaT8teF/1cBifDabMUP8pgZA4+YQuSrSXz3Vm+qkloj5p5HG/EchE/Z73+ua/DRK9WKZ7X/ooShuHYesMDNRjKGqiyAaMkF8V/L0OsWxAB4wh3xoxCef9QKnp5B0DTlGCgJ7tG8Ew7lzPvJDaFefKnkk38rM+K2WlYGLt8rwjcHA1aa+g5EAzv986xtW5HHYnZNJCQTgpnuKM557knjqRz/TdpSwaYkYoI8Ye0GP/mj0nuxl/GDaV6VCubdzUqh1SqB7S28Fh2LNUOse0t72C/jObPUaADDBWH+jXV4mhrky94prenFVUiCMNZhzl2bsbSKNpQPWrBFdXP+hKS1HuLo3BSLyVcfngbEpFthOSWnmrJOVYUCTGNrNd9MdTT7bOoYcMXwfiA+IMvwS1bmweNVPloT9YWyBJfPut242gixG0ftvvUiVjZeXfRjf+R91Le6GfPOsR4C1ADIl5CS+1uvqUQF1GyfddFU6B18e02Wom9OnkBEA+YBnf2qI5kOWTWJhzv4xCRZvXVVEbGXyz71dt07yjZAm1Rbjd84m9WKhqu8zSe9QoPL5FfTutBaEdU5CbWOWjyptb3QXFvCISQelK8wMaEpvypYEvMAdZLsjBb79If9zq4vWmUVrPE5lXzc3g8Zo700XLi1XT5v8FJCw== jenkins@ci-server"
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
