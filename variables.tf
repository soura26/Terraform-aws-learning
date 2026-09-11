variable "aws_region" {
    description = "Its AWS region"
    type = string
    default = "ap-southeast-2"
}

variable "ami_id" {
    description = "AMI for EC2 instance"
    type = string
}

variable "instance_type" {
    description = "Instance type"
    type = string
}

variable "key_name" {
    description = "key name"
    type = string
    default = "demo-key"
}

variable "vpc_cidr" {
    description = "VPC CIDR block"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "Public Subnet CIDR block"
    type = string
    default = "10.0.1.0/24"
}