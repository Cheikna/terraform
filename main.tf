##################################################
################ NETWORKING ######################
##################################################

# VPC
resource "aws_vpc" "vpc_tp1_cheikna" {
  cidr_block = "10.0.0.0/16"
}

# SUBNET
resource "aws_subnet" "public_subnet_tp1_cheikna" {
  vpc_id                  = aws_vpc.vpc_tp1_cheikna.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_public_tp1_cheikna"
  }
}

resource "aws_subnet" "private_subnet_tp1_cheikna" {
  vpc_id     = aws_vpc.vpc_tp1_cheikna.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "private subnet"
  }
}


# NAT
resource "aws_eip" "nat_eip_tp1_cheikna" {
  vpc = true
}

resource "aws_nat_gateway" "nat_tp1_cheikna" {
  allocation_id = aws_eip.nat_eip_tp1_cheikna.id
  subnet_id     = aws_subnet.public_subnet_tp1_cheikna.id
}

# ROUTE for public network
resource "aws_route_table" "public_routetable_tp1_cheikna" {
  vpc_id = aws_vpc.vpc_tp1_cheikna.id
  tags = {
    Name = "Public Routetable TP1 Cheikna"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc_tp1_cheikna.id

  tags = {
    Name = "vpc_tp1_cheikna"
  }
}

resource "aws_route" "public_route_tp1_cheikna" {
  route_table_id         = aws_route_table.public_routetable_tp1_cheikna.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_subnet_a" {
  subnet_id      = aws_subnet.public_subnet_tp1_cheikna.id
  route_table_id = aws_route_table.public_routetable_tp1_cheikna.id
}

# ROUTE for private network
resource "aws_route_table" "private_routetable_tp1_cheikna" {
  vpc_id = aws_vpc.vpc_tp1_cheikna.id
  tags = {
    Name = "private Routetable"
  }
}

resource "aws_route" "nat_route" {
  route_table_id         = aws_route_table.private_routetable_tp1_cheikna.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_tp1_cheikna.id
}

resource "aws_route_table_association" "private_subnet_a" {
  subnet_id      = aws_subnet.private_subnet_tp1_cheikna.id
  route_table_id = aws_route_table.private_routetable_tp1_cheikna.id
}


##################################################
############     SECURITY GROUP     ##############
##################################################

# Security Group for public machine
resource "aws_security_group" "security_group_tp1_cheikna" {
  name        = "security_group_tp1_cheikna"
  description = "Security Group"
  vpc_id      = aws_vpc.vpc_tp1_cheikna.id
  tags = {
    Name = "security_group_tp1_cheikna"
  }
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  description       = "HTTP to VPC"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_tp1_cheikna.id
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  description       = "SSH to VPC"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["82.252.150.125/32"]
  security_group_id = aws_security_group.security_group_tp1_cheikna.id
}
  
resource "aws_security_group_rule" "ping_from_private_to_public_subnet" {
  type              = "ingress"
  description       = "PING from private to public"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["${var.private_ip_of_private_machine}/32"]
  security_group_id = aws_security_group.security_group_private_tp1_cheikna.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_tp1_cheikna.id
}

# Security Group for private machine
resource "aws_security_group" "security_group_private_tp1_cheikna" {
  name        = "security_group_private_tp1_cheikna"
  description = "Security Group for Private Subnet"
  vpc_id      = aws_vpc.vpc_tp1_cheikna.id
  tags = {
    Name = "security_group_private_subnet_tp1_cheikna"
  }
}

resource "aws_security_group_rule" "ping_from_public_to_private_subnet" {
  type              = "ingress"
  description       = "PING from public to private"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["${var.private_ip_of_public_machine}/32"]
  security_group_id = aws_security_group.security_group_private_tp1_cheikna.id
}

resource "aws_security_group_rule" "allow_mongodb" {
  type              = "ingress"
  description       = "MONGODB"
  from_port         = var.mongodb_port
  to_port           = var.mongodb_port
  protocol          = "tcp"
  cidr_blocks       = ["${var.private_ip_of_public_machine}/32"]
  security_group_id = aws_security_group.security_group_private_tp1_cheikna.id
}

resource "aws_security_group_rule" "egress_private_subnet" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_private_tp1_cheikna.id
}

##################################################
############           ECS          ##############
##################################################


# EC2 with private address
resource "aws_instance" "machine_with_private_ip_tp1_cheikna" {
  ami           = "ami-08a2aed6e0a6f9c7d"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet_tp1_cheikna.id
  private_ip    = var.private_ip_of_private_machine
  vpc_security_group_ids = [aws_security_group.security_group_private_tp1_cheikna.id]
  user_data     = file("scripts/init_private_machine.sh")
  tags = {
    Name = "Private machine"
  }
}

# EC2 with public address
resource "aws_instance" "machine_with_public_ip_tp1_cheikna" {
  ami           = "ami-08a2aed6e0a6f9c7d"
  instance_type = "t2.micro"
  key_name      = "aws-upec"
  subnet_id     = aws_subnet.public_subnet_tp1_cheikna.id
  private_ip    = var.private_ip_of_public_machine
  vpc_security_group_ids = [aws_security_group.security_group_tp1_cheikna.id]
  user_data     = file("scripts/init_public_machine.sh")
  tags = {
    Name = "Public machine"
  }
}