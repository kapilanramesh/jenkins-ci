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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8TeYQxonSTeptbqj0HiPKGnTpbYsliXTBh2MLCgoR2h6jeQIhl8QcljW5DPFoWbbo+n6AjytGA0Nd8v4OyfDAVZuofePrMjLSoHSoGAZJpcZq9mH0C6MabjKZNpHtt4NuqOnLgwAaSKuE+AaG4fJb+Z8oJj2K14yDK8b3qaVFGSKyt55LmxFWaeZUDMm6vN5elBr69p45u0Qlo7bzbWyFfpN2GRxWg0TZZZOhlW5T48QwafYjmdn2XGInvKDNLOoodMItprPA9COFMoyIAOLyVCZjvbMk9ARnlBAlsCHYlLHNDDnHGpO1oEswq4guMTjP89w2A4dbW36/JScJrBRm6TcFXox6+xjJgYo2cmdD5QX0wFpdkhhyJGQ2el9uidNFFAJklszYQjjd0GEO/MhiIX7Xhi+AIs7vPTH14p71wgl8qwzIruoxNY1HneP8OIif01PfAvEaATVbqyPDIwePh/1dccewU1Nfttpf7x+TPpSGQm27j46MuvUdtVYA8toa6kDBFtnKIbiH3wctx4IcNonTd10n2o2FGz7jkUOxw7lfPfmX30z5FiVlVygpBMVEDPVnyB0G5QSvP0lQq8fcMevEMdgg1/vQzkJfOgU3qMqCtxeURumI2GyFltKRl5iMD39sTymxfmKFEr0slCMmpaAluyFriKuDskUDICobWw== jenkins@practice-session"
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
