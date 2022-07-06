provider "aws" {
  region = "us-east-1"
}

module "network" {
  source           = "../modules/network_module"
  env_name         = "udagram-terraform"
  vpc_cidr_block   = "10.0.0.0/16"
  pub_subnet1_cidr = "10.0.0.0/24"
  pub_subnet2_cidr = "10.0.1.0/24"
  prv_subnet1_cidr = "10.0.2.0/24"
  prv_subnet2_cidr = "10.0.3.0/24"
  az1              = "us-east-1a"
  az2              = "us-east-1b"
}

module "server" {
  source       = "../modules/server_module"
  vpc_id       = module.network.VPC
  env_name     = "udagram-terraform"
  ami          = "ami-08d4ac5b634553e16"
  pub_subnet_1 = module.network.PublicSubnet1
  pub_subnet_2 = module.network.PublicSubnet2
  prv_subnet_1 = module.network.PrivateSubnet1
  prv_subnet_2 = module.network.PrivateSubnet2
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

output "LoadBalancerDNSName" {
  value = module.server.LoadBalancerDNSName
}

output "LBPublicURL" {
  value = module.server.LBPublicURL
}