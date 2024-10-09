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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCAyX6NIrcyH/STpK18rtbOa8YFouzDh3qneWVIc8NQnpnNY/58KJqGKm8DgOt9oW4gwiNj1brO6uXMS0Mwla/RxCTQ3rmM9cay9WWSTzGkCIXiqasAod4sFYuLuw6/ZL4QkmRlm6SBl8rMiqk4tzzbO4+ERZB/yaQwDeNFuUHC3iwJs9OeYeIraJ5ASjT8dUrQ4YZNImgchVUSDvWwxKZQf2boK0UEkUA/OqgVhGBNPaC4Em9B3tpgA2TowOstPSq2PkxNWDBOwseMZDrWFuifROswsYrnfU05lNgLr59Ch17Kl490lBz9bzc6fSrGsiiYfIBrljMhJ9PSXOcIl2qrd4B/6UU8J8Bv55tzB4p8p+riR2zGj9tgjuw4fc52kmvMfQKHuZ97VCO5Lt/ue6voO4IgsAA1rKhweIDtwGMb6kyi/5awSmGVD8kZiK8kdlt2AKA/Ipei3hdLWEUnsrHStwdHVigOwjfAAyN/YDtkaNfM1BcD3E24bjg9UpzplchHrm/eaYf19PDQ7jufCl8Tv4TEgRPxKqOmcGoTQcP8zGoU4ZZ80uWm0kCgBxO7zfhzw5qhXMLt/VTUYHbEFhR7kRMJ4txXEw/YZ7CTWGrMSTcVCCFtMUqKPbDzj9ZvigNRpe03pTlSBERAD6acQzd24WBY4cvEJNiJnRoDCfyBJw== jenkins@ci-server"
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
