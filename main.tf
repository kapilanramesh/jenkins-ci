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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDyfzsmwOKHCcjZqJm+xGzpEP5PSWvSg2HqGStxEd1wDtSCSAvTaYaLltwdAoAKqYRlf6KQuAptu98X4nKfHLAXi2YUUaGTdUopGJSVJLy4T4Q/z3Rm0VwWTOKmA+QP4O1Upo568Fl8ILMg+ndjb/LTF+thZkEqg1KLPP3eG3xuk3pGwq/EP9SMnh6JN7uyTF4YCKiJajpK9tlzr8gQzFzsnQafAvAqC+Z4/QzoqiRsl5HZo1zKKVv4OWDHfqQ+f2aEs/tQv7FD2siItZG9QaHC6r3ju+Ysabx1JfjsC4ST0Qxy4xMRQkOo8f7fNY2bkbL9kbpikC1+rQ8xB40nNUygrVLmq76JoQMu2wTpw3QEW9vFNY1hmKHnIxxUFXAlkxGgcNMULIgwOu1vFkUTHppAaEpYDj8QO1KRSzeTSIvWC1qgp2TDCIE5n9RajQ+HPu7EEgwOTkOdlYtCyR0eyX7jJsSAR34VP4CosnSBBPFKGa4B/UsFCvlbECCc7/jJQMqtmkLjTKhcIKBqJ4Af9zUDE+EQ9svoDGxHjgCGwG1q4upkzBuREogmg45scxZVRKvlpi5i9iOz9ck49/oC6Y4cdZWkF/vDmzdlu9Tda/Pmu/89Olk/1WhVaov8WX7cCQEyUfBGjQR6eSRQiWgknCCN1tr91qTgBR2Lin63xxOCmQ== jenkins@pipeline-server"
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
