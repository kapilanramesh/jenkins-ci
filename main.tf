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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDarlDAoh5gQF2/tA1XFRxPbXQprZ0WHWymj63qsD+4dOTB+17j7Xv3W++7dT7UugPEiRjXykYAP0QRAGf95506YgPLaDJukFEmzMr/Jsab40Zyt8otKlRERJ5pdMfPs0lRE8PX5QcXtJ6mcyD0kDHl4Q82yiw69lx9zWQHBnmxFl95KgQJAaAr9dV7fP9jScMiLCtzX0kO3MVT6hDoyL3kUhSQiPfNTAaruD93C0oykphMYkBIWmbsuUE7BBpDd4iw2xKF0P233l/m0yoMqxg7Bg9H6ldo+U69SmtCUl++4d3xvQNbvfU6UIxH8X6d6Fwd9pJAtGvcVEdWRtYQx/hvzajRrNgIy4kl3sxamJmcKi0KX/AYEIBh6pOds5F30+qZyPhwaTmE9RwFzAWQbwOesqZhJksav2D1czleAiK2IvA06Mnv0P6Ut4udM0b4WQE6DGx0BmCQY0/JaDCKZ1WBtOCxlxejgw0Qp9niDi4X+oe5+Yw9V6MVPTiztfG2gIZ7YTsbfs9O21jyB7Ri7a1Tsq3rQv2lylDBmg0drZooBwhRPXrvTQ1AgZPrKpSlMGD5nNHUr+P3WxO398EJWpS/xE7mcrPZ5atWCB9Le+Ev2iA5eGXhjuCXmnxWcGDUnbPOTaTpAKx55RxWnnT4OUnienRydbnORh2vs/HIBjDggw== jenkins@ci-server"
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
