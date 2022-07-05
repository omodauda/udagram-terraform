variable "env_name" {
    type        = string
    description = "An environment name"
}

variable "vpc_cidr_block" {
    type        = string
    description = "vpc cidr block"
}

variable "pub_subnet1_cidr" {
    type        = string
    description = "public subnet 1 cidr block"
}

variable "pub_subnet2_cidr" {
    type        = string
    description = "public subnet 2 cidr block"
}

variable "prv_subnet1_cidr" {
    type        = string
    description = "private subnet 1 cidr block"
}

variable "prv_subnet2_cidr" {
    type        = string
    description = "private subnet 2 cidr block"
}

variable "az1" {
    type        = string
    description = "Availability zone 1"
}

variable "az2" {
    type        = string
    description = "Availability zone 2"
}