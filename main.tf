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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCn60lr9K+zEclvLdNAkT+whh2JYy6RiwEeLsJhyxy0dz0kE5fTmfiw/ICzHLOb0djUUyKTPwA/d8tfL56dg5CUgOfwSWcrwC/zl/UafKR026i4dQbT89uFSF43VZyk2sHyQ6rjwGcj4vjef+BriDE5Gwiw9YuJ5VzXsdbfhtae7nAoLrM0/Id/NnBp6ogkkETDWhvmqdSpilNwsqeqNx109f/nD5myIz/a7LinwHBcr3gCmvHdd+7mbX9FfinaSUVQgGv+YMAIt74BeLe1Gr3eB479dISIF6gR3IYB/PWR4VPvnJA3snFs+AJghhOs8Mxx9HcHeRBL+2ZyXV3P+/SweWd0QpEcASpTWbpj/qTTipR/kdjOxEyjFB/j6waEecJ68YR57KpmEG50VQ1JAbEI7z2Fyr4cKdTdzADW41eVd1qLPVIgQWZPbKNAKfTLCQk5Knou1w9lrumFpSjryeIaCkrCmyywVOZzeBggRwsPshyP+whskKHD2MECLU3RPmf6GYbAdOoMBnnjGlvcGFyYyHVx5e0y0NCD4tnspAs2nDRBmE6+bwqxazAFZ9BN0imADtro+lyQPIqzroaYO60JTcGkJ9QdPylyXgW1MtcBrYiJ407TuwqMb+s3L7/w/cAOp/ZkZtm0UNR2SdEVFqnSTwgjnWtEsZvqXqcW7glclQ== jenkins@ci-server"
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
