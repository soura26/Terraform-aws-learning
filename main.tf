terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 6.0"
            }
        }
    }



provider "aws" {
    region = var.aws_region
}


#Security group for the EC2 instance:

resource "aws_security_group" "demo-SG-01" {
    name = "demo-SG-01"
    description = "Demo security group"

ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
    
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
  
}


#EC2 instance:

resource "aws_instance" "MyInstance" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name

    vpc_security_group_ids = [aws_security_group.demo-SG-01.id]
}


#VPC and Subnet:

resource "aws_vpc" "demo_vpc" {
    cidr_block = var.vpc_cidr
}


resource "aws_subnet" "public" {
    vpc_id            = aws_vpc.demo_vpc.id
    cidr_block        = var.public_subnet_cidr
    availability_zone       = "${var.aws_region}a"
    map_public_ip_on_launch = true
}


#IGW and Route Table:

resource "aws_internet_gateway" "demo_igw" {
    vpc_id = aws_vpc.demo_vpc.id
}


resource "aws_route_table" "demo_igw" {
    vpc_id = aws_vpc.demo_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo_igw.id
    }
}

resource "aws_route_table_association" "public" {
    subnet_id      = aws_subnet.public.id
    route_table_id = aws_route_table.demo_igw.id
}