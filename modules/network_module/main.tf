terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

resource "aws_vpc" "VPC" {
    cidr_block           = var.vpc_cidr_block
    enable_dns_hostnames = true

    tags = {
      "Name" = "${var.env_name}-vpc"
    }
}

resource "aws_internet_gateway" "InternetGateway" {
    vpc_id = aws_vpc.VPC.id

    tags = {
      "Name" = "${var.env_name}-ig"
    }
}

resource "aws_subnet" "PublicSubnet1" {
    vpc_id                  = aws_vpc.VPC.id
    cidr_block              = var.pub_subnet1_cidr
    availability_zone       = var.az1
    map_public_ip_on_launch = true

    tags = {
      "Name" = "${var.env_name}-pub-subnet1"
    }
}

resource "aws_subnet" "PublicSubnet2" {
    vpc_id                  = aws_vpc.VPC.id
    cidr_block              = var.pub_subnet2_cidr
    availability_zone       = var.az2
    map_public_ip_on_launch = true

    tags = {
      "Name" = "${var.env_name}-pub-subnet2"
    }
}

resource "aws_subnet" "PrivateSubnet1" {
    vpc_id                  = aws_vpc.VPC.id
    cidr_block              = var.prv_subnet1_cidr
    availability_zone       = var.az1
    map_public_ip_on_launch = true

    tags = {
      "Name" = "${var.env_name}-prv-subnet1"
    }
}

resource "aws_subnet" "PrivateSubnet2" {
    vpc_id                  = aws_vpc.VPC.id
    cidr_block              = var.prv_subnet2_cidr
    availability_zone       = var.az2
    map_public_ip_on_launch = true

    tags = {
      "Name" = "${var.env_name}-prv-subnet2"
    }
}

resource "aws_eip" "NatGateway1EIP" {
    vpc = true

    depends_on = [
      aws_internet_gateway.InternetGateway
    ]
}

resource "aws_eip" "NatGateway2EIP" {
    vpc = true

    depends_on = [
      aws_internet_gateway.InternetGateway
    ]
}

resource "aws_nat_gateway" "NatGateway1" {
    allocation_id = aws_eip.NatGateway1EIP.id
    subnet_id     = aws_subnet.PublicSubnet1.id
}

resource "aws_nat_gateway" "NatGateway2" {
    allocation_id = aws_eip.NatGateway2EIP.id
    subnet_id     = aws_subnet.PublicSubnet2.id
}

resource "aws_route_table" "PublicRouteTable" {
    vpc_id = aws_vpc.VPC.id

    tags = {
      "Name" = "${var.env_name}-pub-rt"
    }
}

resource "aws_route" "DefaultPublicRoute" {
    route_table_id         = aws_route_table.PublicRouteTable.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.InternetGateway.id
}

resource "aws_route_table_association" "PublicSubnet1RouteTableAssociation" {
    route_table_id = aws_route_table.PublicRouteTable.id
    subnet_id      = aws_subnet.PublicSubnet1.id
}

resource "aws_route_table_association" "PublicSubnet2RouteTableAssociation" {
    route_table_id = aws_route_table.PublicRouteTable.id
    subnet_id      = aws_subnet.PublicSubnet2.id
}

resource "aws_route_table" "PrivateRouteTable1" {
    vpc_id = aws_vpc.VPC.id

    tags = {
      "Name" = "${var.env_name}-prv-rt1"
    }
}

resource "aws_route" "DefaultPrivateRoute1" {
    route_table_id         = aws_route_table.PrivateRouteTable1.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.NatGateway1.id
}

resource "aws_route_table_association" "PrivateSubnet1RouteTableAssociation" {
    route_table_id = aws_route_table.PrivateRouteTable1.id
    subnet_id      = aws_subnet.PrivateSubnet1.id
}

resource "aws_route_table" "PrivateRouteTable2" {
    vpc_id = aws_vpc.VPC.id

    tags = {
      "Name" = "${var.env_name}-prv-rt2"
    }
}

resource "aws_route" "DefaultPrivateRoute2" {
    route_table_id         = aws_route_table.PrivateRouteTable2.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.NatGateway2.id
}

resource "aws_route_table_association" "PrivateSubnet2RouteTableAssociation" {
    route_table_id = aws_route_table.PrivateRouteTable2.id
    subnet_id      = aws_subnet.PrivateSubnet2.id
}
