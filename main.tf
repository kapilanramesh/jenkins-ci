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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCRMXsTkcMYDXMB8BwCWx/FhsB6/bhE3CQVR01xzM217AvMCYxvSYJ9ZfMNNyPWZGEzIrXNMiedwqVt49PmXB5gQusJipdG3IEFsUXPaOWuPK05xk/RV/UOeUxY7A3gHTVFTYgZekEaAv2tEmp+D7RxYNXm/8LxDu7Ykcj+kfc3vHgGywE/t6RKdKw1C9BPZy/Srmt2FFPEjCzdFyBAzrnLPlf50DZof2a+XqIYuJ98va47Rj0n/CuLkFfV/phAKa0eBjurtSlmrZokLRs+nYGgUL7fGk7RUwLGJvT0AgPA40AWPcvsBqFEt0ilRjTOHhi2Zb3rT+ekjjYjmWftuYtVuvAJ9IXxb3UHV20mqk5TVMlf3MdCEvTkyPAWqtc43Ljr7hMxcMdaK3sutNQfKrE4packd1/ea9AeeFnD54tCYXj81N+HgHotHjAllkbejQVzJ3AD+EzCrTN/eDQGHIOfvmQZUk9eavjX2GZVClY2+tpXyHw9feLXqtCl2LHmgfs= jenkins@ci-server"
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
