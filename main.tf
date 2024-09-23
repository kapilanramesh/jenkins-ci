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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+rL2cl6zfCubJHlkJt1+TaZV2al0vPiAL8WvgJr2C/zdmgni4izgtyE94q1NyHzp7QLhgk8nc4UGAlVyGITL+6OUSx3OTj4glu2/ks7UqJG1fOMZd6A/PwnzOblhldkb3U2DGWvd/5D4MwN4NKqqlzakyCDPBKREr8RtY7wV48oRHmenWnwcxVQUEkeSFsBgrFeskh0wgzYv9+jwvMrSLFPJJ19af1wHo0TCiNlKUZpNcRSCIc1QIrFzFhnJAeKm44B4mZQUqRQ9KdEOeTo42nXMTwA2htaNjZ7NCjaWk9FqeTZBszeWDLnzgDoM39xa4fOsiNStNFtQR9Bt67JGx3VmAvnx5nTMcyuSlFpO4n4+WPOKJy3ndI/rydTGqA0jCFDj4xhb/1eUEB3OxpdKt2uDa02q5G2LFGiASae3bO/aT4WWog1Z9Js5ZVPqwR+/NgUzK49AhAixoarDbZL5t397ge144kAIdJrHNJN10DZAeQ8h/XkiAROumCoR094d8tj/zEO7fHHIh6BYn+fJavInW2l2FWn7C1fI6ODYwl31QNYZVHa4O84RrgriZJ8QCIewAl9/kK+x0Bby5WR68A2bxPdsHkJ1OAKoz4GKA9doI0kXhDeXpj5CcB2uobCpD688ffhx4bwzPu49CebP1TH6E1NGs6Eoq8iAIfPgnxw== jenkins@ci-server"
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
