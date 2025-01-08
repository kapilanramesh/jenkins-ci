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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDLcgOt5AbQG2W2l2DspFsGq3ZUE8J1+c2gjogSuSUB3ZT9HzOSoAi4p/cPLMtI4ylia32xTe7rm7nyPgBsch8eKq9F40Xbdeu8wg/jM3Ct5jRFnSx8W3PmlE0jjtUyVQwFnV+XtYSVT9VykRr+1OtF/48TSpMl4m27qvgU35yCMXSJ+Mcr4eKKOA4xtvjxYNYy63mftZN29jYfIUM0ooM4TX21lyE42Ph6FgAQlwjBtNHcB9lkEPSjeRTeMcFk+VAVvv75onVbSrh/tH1DaL2PNLtkTR7s1krjogegOvUTlp6BtEtijDGmNj2tB+sAmqloItAEJ3AtVNFAb5zCRO9Qx7qL0VXqR0lXqXYwF/9olIBr7Teao3F31TKx8o5cDrFPBmOzX9wfgZv6RuN2EPHeNYvGZEiV/G14ZVC/gLyTvXMb3thoBNFky9JgTr1qu4L0MEE9Wmm97W+7AUQfNkRmVuKyY9KL7rdSjPuaCxrk6+J9qUkELzUm0v4D50a0T3nssQNaL3ckmcrTSLCR51TcQwHcA5nnoclEIZ9y6j2RpE0Vxuy7OgO70f5GSyKrfX0+pJvHdJ/kM6YZPSoGr3sE7tJUSquv3jKGZtY2Ekv0kKaBufObHQpGV3gkkzDg2A2003cbZAQHEmVlaQ/ioQzqVyYe6hTDFz4X0AXrfV6rHQ== jenkins@practice-session"
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
