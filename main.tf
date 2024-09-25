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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHSq1IKlzcS9qMv8bd6NWJ3XCLFCYWX1QdmfqmFb0YRhslaa+ebb7FT9d3/q+u7Szm+AVtY8uGCNUZp4ZzL8F1Uv/J/TUOaR3jBB1YAMKx9iD6tkI1AKGUW6Vt6eN+ug/gGXdMGyyERpDyjktSLl33cv3CTAZ/1CFqg4gKwzxVhWuRJYX4vVCfDjH/XpM3XlZtIbbi9UAkMjuS2M/nmMWviSA+qSJrPFAlCPHDCrdmf3tLucb2wbU7Gym1R52SURD2nNqjvhALThcFnqjbIJysoJXamMuADzkNx8RGBgcSVVgITpDjJssZjifgMx1uPCS/T3r8O6juJ823Z+UDRt9KvnC36xqTReu8+PBo1J+5reI/K1S+f5SoxitDXo4O65m39If/MHKsaCjY5RmvFtmLh5L06aGPbTw1dsInrGui8C4e1bEo0PcZCeWUI1QTmyuD8Tc+Vm5plhhAxQHy354AhG+B47tjhNc63YD6v8slGMU5y1MxMKQwcNEaxmFLEC1iNMiQpvZkIdX/65/yt+UZqCgumZaTbyXUmubF9C3iLWO+RsWWfyXlSeUFJrGylbHTH0lXUs4ys0nMvpdMIn+EbvQVles7KkOqZt6qjxyXu9NdXXVnOzt9DFQpbCK4ySRYGx+ojHocgQ5XQMnbsdcgeQuV+jHJRpJUQoyW7V1zmQ== jenkins@ci-server"
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
