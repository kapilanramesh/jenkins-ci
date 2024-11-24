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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGhASKsGCTvwRvIJJAIM9p7E2nSQoBjb00g1Ypl/48VjE/T3GydxYr51ldFgSwWbmRD3+BM42p8FhpadwMJ2tnoUwbpHjj8mykBvqbXVE1czMHYyRrs9K6brd6C7FhsxNwHphJ0zFzATdD6+oeUnvoTq/TTIs9d8JAtiOpKOBma1tnNQbmLXe24YeXTEdZr/gRzLHIpIVZITXGjod0KzqIuVjCuWFeBBqAZQpnqZizRh6VXDs6TSDnweTmGUgoipo/8C2hCe1JsZNeym/90FQHWeq8j40M8fc1jC/75j3mcV8Lu+URghilMfs30sO4/RsUGU15+o49GPxBIYF1nGIr4oFC6K3AqbNU0OH1nfG9VQ7lvCJMQJyhaNgZV40lfMC6jiggrQOwR6bZUeTaprIZf4WkVxCclBS3bkK4bXrqIYqyrCJBE7A6seRDPrRBf0n4f2G5LjByeS71a9KCdhQEiNlbgNZq+d+5bA9xCt6aaHt15FCBgA3BVCf99nGZ93Uoh+42tFx/PmCE4k+w6CrBRZ8ev9yQiUu0gv/unaHZhzk2ioJrSmIq4qya21DwTVftILUcAycghjXzs3ZU5/H/YI7KOmHdjVjSNskA9PoxPFtIhUVIlNvKtZMp2aqSRF2qUyJMhdXVxr+gPN6VJZZx5tIs9Q7ZrBGqSpDCnAtzjQ== jenkins@ip-172-31-33-69"
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
