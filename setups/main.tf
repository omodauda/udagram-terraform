provider "aws" {
  region = "us-east-1"
}

module "network" {
  source           = "../modules/network_module"
  env_name         = "udapeople-terraform"
  vpc_cidr_block   = "10.0.0.0/16"
  pub_subnet1_cidr = "10.0.0.0/24"
  pub_subnet2_cidr = "10.0.1.0/24"
  prv_subnet1_cidr = "10.0.2.0/24"
  prv_subnet2_cidr = "10.0.3.0/24"
  az1              = "us-east-1a"
  az2              = "us-east-1b"
}

output "VPC" {
  value = module.network.VPC
}

output "Publicsubnet1" {
  value = module.network.PublicSubnet1
}

output "Publicsubnet2" {
  value = module.network.PublicSubnet2
}

output "Privatesubnet1" {
  value = module.network.PrivateSubnet1
}

output "Privatesubnet2" {
  value = module.network.PrivateSubnet2
}

# resource "aws_instance" "webserver" {
#     ami = "ami-052efd3df9dad4825"
#     associate_public_ip_address = true
#     instance_type = "t2.micro"
#     key_name = "tutorial"
#     user_data = <<-EOF
#                 #!/bin/bash
#                 sudo apt-get update -y
#                 sudo apt-get install apache2 -y
#                 sudo systemctl start apache2
#                 sudo bash -c "echo Hello world > /var/www/html/index.html"
#                 EOF

#     tags = {
#       "Name" = "udapeople-server"
#     }
# }