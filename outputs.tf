output "instance_id" {
    description = "Instance ID of EC2"
    value = aws_instance.MyInstance.id
}

output "instance_public_ip" {
    description = "Public IP of EC2"
    value = aws_instance.MyInstance.public_ip
}

output "security_group_id" {
    description = "Security Group ID"
    value = aws_security_group.demo-SG-01.id
}

output "vpc_id" {
    description = "VPC ID"
    value = aws_vpc.demo_vpc.id
}


output "route_table_id" {
    description = "Route Table ID"
    value = aws_route_table.demo_igw.id
}
