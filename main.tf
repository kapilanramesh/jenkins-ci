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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWWH2MKRzXJnEquv6/IkvVtHEBtGx992ZF8JHy9gNY7tH0/gB62In933XfJiNguNy4IKTggmx/jfo3325acPd1lOFRGy8EkAfU+Tjlh0wkwaARRXI4hVCbblz5g0eM1+EbO+6351DTmVaIW9ToV0uTQvCTomkGM7UGWDNx/JiNR5httQZ1dAl9at+/xCeBsJIBUqwZN4LsJSsqsOTreogE1U1c5QKhGpn5TLiY3L9kBmuaRVGqfaYFZjL5+cY/hHRg6Ykmg3Nys7at8KUAnfW0HMu93+vxvSN8sZSaX68FR4HFjNhfmqXg5eJgVUPAa9z1fRT4im4931PVg4O3nwXbQLYUVNqWw0Q+Ahe6gG9dumf/S0QtGlLMfjE9zKjzVCoFkmdyacK0jc/Hk1EixgbjN7kG1gG+kQ6DwyylFvRU8JaiNzYvs4aN8YK2jy3mI28ziWfRmWYWEnHbFk5Rbb8XlPgYPl5mYZeGKy25hD6aLat4l5Q9zRgssDuS2KdhFnvHeIKGFscwICHWnyghT4wi2G8UAlgg6+toHuKkxViJO+8QJazro2MTXVN7JTiIuhIUn/eO1C2SeRUkzLNZi/2/JtHlt6lJEWViMyr8Q5Yb2WMHuLCb9V5PhSvXNcTmx/rJKzzHCiHJ8J3Y8VaJc4B1hel80uXTSeoEaZvuiTAaew== jenkins@ci-server"
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
