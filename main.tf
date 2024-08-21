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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqrZQbG30KkuSOm+uf31LfV17VNF3Rlv+QUo9kONFgcgN14H0vEYEX7lYdCwBUhat/5ts6VwboleO6GJ+cMPh7J2RWqlffQ1B0Vp+1RtRDZMIszRb/RaXiiHkOKsu6pixu1sTPM426A/slV8Uk6aeOmHEfL6T7uKQHjM9DOailKJADkKFS0P8d3FrnYDBHqFQg21KTpvXQ2HMs/U+C7IAg2PbOqSXlFTXENeix6wuLdhmr//I0TSP0ToQiOhL0cOEBYMOG/HCypu/jn0BV+QmxRBG1fw3w8uhzkklja5cFSnUdUK+d6iXdUK0npKkq5880HCb/VWyVyoDtZhu62DSZj0m+TLPMvY1ryWk6I307uMIC9rlnONmUZKSAs2o6x7S+mUHjVXK76XpWbC08HEtzs8v/J4+GkxOiJ1SleMWKMmCvTB8eHCrQvC/ODJHl3DMu66jQ4vbEqnKokl0npUNiUf0lBZ5oAltpLPK0sYctU+h3J6nXd19qdCYAvATPo58= jenkins@ci-server"
}

resource "aws_instance" "example_server" {
  ami           = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.micro"
  key_name = aws_key_pair.jenkins-key.key_name
  tags = {
    Name = "webserver"
  }
}
