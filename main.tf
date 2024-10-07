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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDflCmcfOeiXTKELaYVLejQUNqthmDaWmg1G6R7zdiZtJck8sw+2b2YBFtqUDLpVD5JNZKaR+l/SoizP5QQc8tVHIiV8aGYi+Ej4blgXQjuCy88+8/JAB9Xt7I/d/jUMObeLcDpnjgcB4JFph/iqOvVdzlqzzb76NQCMai+UE2QZo8QfTQjhkcCbqGZva9n85inkFGc5GEFx1A1UQLXAqB55hmaw02nlHhplj6Rw8+AAx4ZsdCZbyufa0WVjZ/LCenJTVtQQaRoVNiq7oMJZGYFaMXdqGc7Ahy/VbMt8UZUJebm72ImPrC7Iwyh+Fictg/3MG1sMraUR8/zEmoVGV9Fvc/hcgsZXN47muNj+T+0V+A8RldAPXCNB4wXDd5DicOOd+BkmOlMAt5ig5X3Q4LmbVfXYIVIbnGcqlV/Q+Q97kOUT4KCgD/reMNkGk4GD47ToT81sN/U9xo53qHAFcd+DmusS/9e+MBxt/Pbb8n3FMzW7Kkdyplsq8wpe8kwYiv0lwP3smQHiQ9zqFisj9ga5vei6x4UOfOcQy0WnhV4tMaskFLn7657KuZbMcQs0IgA9MzXhs2t0EAzcdZ9dCWIgtxryxsfrTrMWtQXA9EAk8i/E9p1RcRNXNX8ECKSFbS6mOEuCGRH5BDWlMOWvcBGrgkeiRd6AxBtuefOpusCwQ== jenkins@ci-server"
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
