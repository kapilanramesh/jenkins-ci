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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQChr87+uwImSVSWV4yBD23A/Lgja7yGs+Q6Z7X4HS7VpwUn/W12lMKq5gAOijmnPQgBcZmdCmwIPJ2Kf7vIosHOZRoeJZLsBWNnBXSOxcxU0OFhsynLs2pJ6NJvxkhcbUxd+0rDbHUgGfP8CGK91SfxdmDNVNsaZoUKtKNZiphrb7J0sVMxALUja4PHV08dQ6Cy74Iys5O7CwcvU1jfW6YO2rgzMVmhvkNs6wlJ0Q8P/drQE6v4vExt/PX8yeZPQKvz9NpV0ZKzYmu1E2R6b6XQq2C5ARq5LAdGUBVLkEpHZ8OBrk0EM9LzL4kmoZZGslJ+c9+C3iY1GPBy8t+aBMOaGei25NR4T9MKmFfYNjuCEUdF3qEFcfHKgHdTP5GY2g5VwjrsOelit3vZmF9kTFa9VTFXc6HJ8jHNBXknP8D1CGUSvAjotYXVcMwlUnnY7iJAJfswDY8mnbn3WSizL1xPxqHexqNsOpwAjkuiwaz5H8k0xSq82C965j3x6LGpIgc= ubuntu@ip-172-31-24-34"
}

resource "aws_instance" "example_server" {
  ami           = "ami-0497a974f8d5dcef8"
  instance_type = "t2.micro"
  tags = {
    Name = "webserver"
  }
}
