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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7yY2q12F4MR1vxj1xrzW3TL+GDlqsstflgjF93M8NOsALzfcDpfJSEQn8ddFDAyfPZNeMyekGA+vDpZuNEb6My7/PhiI00EdI0fBrA7nx2LjEhUeWTeaQWdV4BQ9PqDQJ4esLncKJdTzGrEMxfPJAfTxXl4FxOnTt4jFnpm5z54wgJL8O3RotS4vUzU3RjCGBpAXVQ19MVfncef9SXX4wbG/+N0F8/YE4+NEZMZKpgml8cwehBHXfc58LKNC0EDFtViR87+i8B85pJ+0Jjt1xqbtqxcoW8XYtUQUPktGuTF9WTrm5h36IQHQC5gnj8lGhqRxWqP1xHLhpp6wiH6tig9di8WKgT44wGL3VTYHHV54ZtXBlRdMyXvGzoGpaxZ3Mt6JKp+shfEszIRjJNjIAHoDYbvf3NJSGTkHnW2uunFMlrv/zTvqthwhAou4LJjYK8mrmWkFUzrd7PJgVhlx09DmRq8co+8fedtpVSwHQcVg+ElmRbWjRS6UXZBMo8gSkmqU7s44Kfm94vuoiJgY0VZ4hPRijpcGDZ3NIHolz8qMOkHtRa55MTKUDGmUrhO+YKoLs2mt+keQox6J/cBv9Lg7W4aEE24q8Ce4wtT6gvcVLMsyPKTJbPslEKyyASbovqeq3X3vQn1FB2HCHJ7KELZzBjeRFEaXrG2Hu/hZMHQ== jenkins@ci-server"
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
