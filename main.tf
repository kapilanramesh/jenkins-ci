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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDeF9B4yL/csYn4dkE0PC+f8BmXx3gDW8ucsxGox/9tvNWX2Bzwj56vonakC94rmaQR7J4hqEIk81ACzeJohmVv0XvIBYBdLI3qMwgSmpNjwdrDdWmNkN1SLnU0czRHU5pV8pQmH/76Pb/F6GJTM6uB/aNSJH6X04hJ6tExYvV7SsEPOACo2BKeFU8par+mpR485VFfqjTa/1PfnxcxjJ8VxLKvfx92NLbTcsneEXmqoXaBg/hB48DU8F81HFnOmOAOgPGsVjheQVC2a2JJfrLO3ngPVtzZhf/yipaInhARm46xpaolrRvh33OsW4HXvxjHPTcKFxg/ocqdoe4zwvFiQ8h7Hrd4OnOrQbuwUOeNoLwDPGJJEHtZ9rVrns4dF9TZ8uKXeoEW8WkAsPsVaDwfxmACBIRSF6mE7EfOurH2OlpW1noDWx4JWZ8hGuN0fChkobktjLTySK0IQBrtdrCRduFW0VaFDq6UbhSn1Cgn1Z+LwRxiuVwAMjv3T3M9qwB/rIwVYT3Np5do6VnjfODV9GDR6hytfZWE/re0FznmMz2IK9eCUr9MTbzV4YVjvXPydnfBnVE3XxOjaWq9j7DfIZKMuxs2TmJEzWgboyd8c2AvLDFb4/+Uvl9LhQ18brPlcBGzvDCT8hBaNC6y81p7sWwKlTJqn5mBwNu/kijm+Q== jenkins@ip-172-31-24-90"
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
