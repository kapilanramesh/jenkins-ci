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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCXw12M3NiV+8+5oYJFEb09zLcMpYZ3sdsEPsQ4gIFK5SD4oX0saXShiRPbqo+g/x8iR+UXyd4yDeeijJexOv1AKvGcJgdcHO46NRJX+0tfSE9QkvbSXKgNrQ2Gfb7+bMZO5nA/LMmx+pOxw/1oCBOVFxzwE75FN4Ja4bLDDgQ+XdI6q+/ijDp0cHrZkv+hZ7zL2AiffjVE3yUSUyiesBXLpV00RpFtDetZDTUtfqjGmhJCvfegL6cfyIHv4abZx75We9aO+3aWSVj56r64ioAWMshy1D+/YaQ90SVzDsa0la5ZCFbKznZntTsjD1Sml8QghEmC6K+7e1K0T1ky6jI5bGWsyE1ibcGfioj/O9yJa3sQYB/GNkP85o/fVxCVgEwbbtFd7F1+b49qRaqIODC7Xsq4Z+EeqBp2dpn6UbnXqz5DMi+RFf4h/j/ORlaprqaf4m7TTYSsDVHo7PY7aW27NW6FP/3AGjBZcA6Uj70/tPBJ1ZRBJRWiktehjs8LJxs+vWYJ4taJzRraJCKGZc/0qT1UYPvXVhqLGt9jB6MDiH/miFPU9cK60Zsvwxvih55j8/mUBGbxdbVzqTrXxTmdB4VWNkBvucgUdgmdm3yyq+XHMkIRwWPbA54HsB/zBlHzXES8rpFRVEM0nnaeYIcmrfS8bIzhWoVytNhGvS0e/Q== jenkins@ci-server"
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
