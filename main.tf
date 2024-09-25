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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCyksGP/kN2FOYZRgjXG6U8mqNchi0yjpvsaefcKPMrwVIGwovoihshfT9Z0AmdSntWxeWwnzKqm1YzL6zf6BzmgnHYfRle5yffnCvDxJ5pYzj8NWxZvfeNYuDavMo24D3H2LzDS4Zso3m39SAtXK1Ljxj0qvf3LTF/WwVa+oLTlhv3Qoy4WHib+5y//2uRJUc2kL+L7J2nwY7KRYo/q4dhBX8+K71Pq8+2nyAZadrM73fiKwQh8TUytipjBdJCHsyTvOWxAnPR975JnP/w5D/nNvUwgi6ZzEiesGaDerIfGSfEUXkDDhjv9Gl2wbtrAQMryyZLFb563S5qicyOpY5WDi3WxO2I9PA8+IqfBSC65AcT5krN7RzgKetwTGkb0NX5kDweSSI58oqo75x7cU6Jq2CHy8eC3uXkkBVCa1jcp//FblECHgkDY9YL4VlgOiJunCFeWPaFKNJ6GP46bmCUFHsB5itJEH+Vi9RwV9dzclUb7p65ew3PA2gHvEIdS1SCs63+4gHGtCUH0PKbvSP1H0B5mTJcY5ml2OcgngVenvWfplRS2NreAJdkXnklY1ctHCBbAHlKRYC8gOSYNlzydFTR/Zw+s/SJvUwAO/LEIqQZbxD55NAY3pS1bM/dJoJxpTsYmaIYVvBdKoveXEz/O4F2N7M6zYY9zhv+dfcyzQ== jenkins@ci-server"
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
