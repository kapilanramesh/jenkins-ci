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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDq/j3+QZtN4SunyLPamkZjSc9HwMP6VZ7qjk8FHHovQ5ArVSoEDxhcUI2uTzau+eKAO2T0HTdK+ptwLq/1kq1bSI+JrVAwg1FYo57O8taGn6DNVo/KAfCaLNbzaF7mpoVsxBkRgIkCeyy12ZKueuWQWMLvbczU2nqZTMy0BmsQh0fwfJ4TCrB1YsDLm19Jty/eRFAh9/Y4703jJGZlBHaCydxChyuHhFZzmbH3fQOB/7SL87Nqhs3wiq2Xz92O91OnRU/VgJG4JK1fGVYtAcAwVvGlV0eIZlQLIlxz9fFgKl5DJsfraWNxi7Mk4y6inxQ3agiQBrzjDw4Xaisc6FK6CAFDBtZUzRNhjiuEgknzpd5/7+lOcgLmxdSjjvjv/v6ZkFO3LvZAavi3vHer514d2BWmhcsu7FFo3JoQtAKWtDbwfn9BCaCzPIOuJx88RHKRi2EfQbWoU+MTYscfuCiURFDMi7BWtbc2wdK5qfR9qgUmFuZXQ1wv7GH9mLNPHVKcs5oj67fgRP6Zxc02ALoaM2MWtQ4eTql30KxQPvQw3OKzZOsudyLUgpPSpkXpJBuYqUgtVeKDrPAo8cPcEWdxVqbYgGqivQP/jaooYNZiRJW9UpJ027b5c86csQpeRAm/MphnkTenIaBVO6mEr3dI1BwnANIULRAaX3WSV4Q7ZQ== jenkins@ci-server"
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
