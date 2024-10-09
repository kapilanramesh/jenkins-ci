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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDp7EhlskR1++Lxno/jTy+VJxegL7mZEd2M4sKkz/1aWY23mYYfN67hNjOEZCHbge2Sg7OErnQqewGRdchcuPtnF8P9cwd8Pi7rbMaRQaPm8ZqP/aDt97RbS/jXcSn1skiXpy6OCNf3rhYe1FPLKRygro+t8A++29Ui24EPsUgCuMz0jEDMsyBvUl0xuA6t6uoodz7w55YFgZPp0xrAbbgHKOHV6ZwQ6Vi/2WGmtnWiCjEAwJ7VOJchfZxlhiKPYsDgkNf2ktd5t3jdq2Hyo11Hk4va9gYIT5zk8ToPcCUun334iQNl/hEDPsVaFhLCLiUa1kA3uCP+43dnOaiE0T08P7ZwgWscqiZmkpB8emmsStSgVGFIIVD2/TK7qlTKw0RuUfu7LnCfgdD/EZLfzVxjFR+cSFTG9sIq+9YPhPNAvgoYuhcysRwvY0tPCxCi7OKlEDWU6WJq6zaCkhqFUcMw+QjUir0zq/Kpc6WPEBG0B3jcA2GYD0kXK7I1xrxUNMbrjEp5GUTIvLk8zRam8v8M+UBxm193YI71EfZrUf23YuNe4d/VsPdJcO/lPk4iP3uBd7cLciceBvsT6QOxDXKlxDMF2/2gyZjvNA0bT6Z0lWU89G5EX5JHVcPQ5kQlF7u3AEZWp0vPkDhoVck/XCeAY5ufL6lxnFhlqL0LGbPVRQ== ubuntu@base-machine"
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
