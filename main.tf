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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDhuyMJNUUUBSCs0E9D6GhisldGZNrIUkK/Xl40fvKVBOnhkHgT5r67kjthEPksSPTjt9mrfr+s6gxxV2R8qOAFX4XCgcLpsGzKI6k1WG2PQaeDVAzMyqEuGBlkDBDnQdm/Vlz1ENIY5e1at6209HS6zWPkRpSI7KQBix03dFVflaHNHErgeXKaf7MBrrH8q0+yXKuooZDyGPvL5mWXtNXbE6t9m9EgY9mVz1GmolMHpUhv2dDy8dcWRkr9xZPwogtqZpG3/mMikWW24FwqAO90y5uWboeONlLrDOd7mgMJcnCA45+TaMmIgus5DA/y9/mjej7y2JuCEosaYLvScCPUoeGIoan9x3XlzjAIyMpXSfvSL70nG7XxaYCuv0avNSj/3m717rTMgDbAroxhgkI28ljaMO6oHKK+/V/U/wtRfO7SLIJuNvy2EGJEC2xOvjli873/GlXg8/Bf4XvENBlkAUgNR69jq7nwq3rEBxODtieAAi65URL7+sfOTBfQKyW0gAI1k6Lw097LP7H7Z/ya3jwKROZaU0QIBdpF4TR7qveu8sm1KDOjQan6q9xaFiGDrrPEJ0Sur5FmDSxjPtTUWm+BOQ0phsw5NEd33leqQnRZobdfhyKmOeDoH6zEMhfNrK/FPuxcdapwYNCm+cfy6JjaTUbjdL6OqX+OJ05+nw== jenkins@fs-server"
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
