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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQClBoatEyeKr6vQESvPs7SX2yddf8gdsC81mfifNvrxUWIaB+/oHIy46gU70X3SADG28m0BkXMpkLicdyX3FFlt+onI4m0HPt/SAcPdyuNptcB7M59dNi6rwz4W6tXUnsZvGKZELZNjJgRKMgbkhwvYIxIVbsrHrvdtSOofeXYv/p5qoOT4HJ1i7G87XxHXLE5N9yPbksRwF56MbA+PTb6SXsPMoQZBdnDM2TFDurK5SHrFZQyDjt9ANO4sXit1m5HiBFJJ+pP6ITLxvMQmn6xe35p7AGbYUHTEfOI4GA07UZkigRE1IVqNtWEEIL6MrroU1G9r2JcOOk0+KgV85MmidWOBBcEILQxWvUdU+XSy116wA1v6nxk2fBAf8pAoiWA8yGe/OHCXVVzkK07upwnhSpUaIXMFjPWbXsaizfKkmUxSmfnfmUShlwn4tUR0hhXE1NeD8QJNyHL+FZOF5NRvAoKnGaExTU1e4JQ6npuXzmPoOPdmK1XdbO9Z14eFjpFCgNQj2GTT59XFjrhKNJ+dPJCVYYNM6shenaUgcPoGicz2y9xXnCzg5esNKEw/TgZlW7McX4iqjsCHthz5RQXleAnpNRCH4Qj1Z4RgRgZU6/n/FpacJHtRHsL5mAguU5TnYfTNPT4aJZGXLinTtiBnpT2mYPNrho2Izll2XBsSpw== jenkins@ip-172-31-33-69"
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
