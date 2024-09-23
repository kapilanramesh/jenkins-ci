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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCdp+emE2jxEL+EAJgZT3zXAsd14iZ3z4UUZVtm5sxkf9F570GkLaepYu1dtpLyEqFq0wLMmaONThyibIPe1mQ0L3AjsiAPL+mFswlmuX6uW+vE6pk6mir639JpKIy6eXYpNK7IDjEXXNOnuOdLTiMSm3eZNRnzYfsm01NXzYTB2FD/8JLBSC59a1D7txrLca9yNMieOdhpfuSjUejuKRjksV6cETu5NPChK/kRjbKk5P9AkCkgpUl2HD7ktHeJpBcfT9gaijiRIvxr4FP63DWFngZpLwaHY8ZOXC7UujsvJFIgOa/QzoNwjkEKSaASZOJt11g6wfI5/ezMlna8iFviKisgTrshVVKMaqjeF+UrMxyr6kbh9mdtidWZvSOaGalZEIllLoLnZA5NeqpsvmpPbV8Mk5+iciJ9sEMDRLXuEkYsiLyLRfQM8Z+ZEYavOsmjhf/4jphSHz+bp/POO+VM2IGmVoPvdzPFuRZFRkGuWbjmJO77Q8NSI+1yAeVYaI/mMQzlBGVAGmzM61ENUypeLHFZJ+ivvrdDcqdIBvKo2EJZuv/kz353PGTBYRh3GhJzVQZ7Hw0U426Pmb5TT4Xj7KLFDN8FQM1uhXfcLzDF8IiJy5kB0QWTERNgvMZmxj/7JqLt+/tQyueTA+QvvYf4BM2YomJmibUgDuI8F+BcsQ== jenkins@ci-server"
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
