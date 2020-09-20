
output "private_subnet_id_tp1_cheikna_id" {
  value         = aws_subnet.private_subnet_tp1_cheikna.id
}

##################################################
################ NETWORKING ######################
##################################################

# VPC
output "vpc_tp1_cheikna_id" {
    value = aws_vpc.vpc_tp1_cheikna.id
}

# SUBNET
output "public_subnet_tp1_cheikna_id" {
  value = aws_subnet.public_subnet_tp1_cheikna.id
}

output "private_subnet_tp1_cheikna_id" {
  value  = aws_subnet.private_subnet_tp1_cheikna.id
}


# NAT
output "nat_eip_tp1_cheikna_id" {
  value = aws_eip.nat_eip_tp1_cheikna.id
}

output "nat_tp1_cheikna_id" {
  value = aws_nat_gateway.nat_tp1_cheikna.id
}

# ROUTE for public network
output "public_routetable_tp1_cheikna_id" {
  value = aws_route_table.public_routetable_tp1_cheikna.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.internet_gateway.id
}

output "public_route_tp1_cheikna_id" {
  value = aws_route.public_route_tp1_cheikna.id
}

output "public_subnet_a_id" {
  value = aws_route_table_association.public_subnet_a.id
}

# ROUTE for private network
output "private_routetable_tp1_cheikna_id" {
  value = aws_route_table.private_routetable_tp1_cheikna.id
}

output "nat_route_id" {
  value = aws_route.nat_route.id
}

output "private_subnet_a_id" {
  value = aws_route_table_association.private_subnet_a.id
}


##################################################
############     SECURITY GROUP     ##############
##################################################

output "security_group_tp1_cheikna_id" {
  value = aws_security_group.security_group_tp1_cheikna.id
}


##################################################
############           ECS          ##############
##################################################

# EC2 with public address
output "machine_with_public_ip_tp1_cheikna_id" {
   value = aws_instance.machine_with_public_ip_tp1_cheikna.id
 }

# EC2 with private address
output "machine_with_private_ip_tp1_cheikna_id" {
   value = aws_instance.machine_with_private_ip_tp1_cheikna.id
 }