# Creating VPC
resource "aws_vpc" "My_VPC" {
  cidr_block       = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

# Creating Public Subnets Using Var
resource "aws_subnet" "Public_Subnets" {
    vpc_id = aws_vpc.My_VPC.id
    count = length(var.pub_subnets)
    cidr_block = var.pub_subnets[count.index].cidr_block
    availability_zone = var.pub_subnets[count.index].az
    tags = {
      Name = "Public_Subnet_${count.index+1}_TF"
    }
}
#        Without Using Var
# resource "aws_subnet" "Pub_Subnet1" {
#   vpc_id     = aws_vpc.My_VPC.id
#   cidr_block = "10.0.1.0/24"
#   tags = {
#     Name = "Public_Subnet1_TF"
#   }
# }
# resource "aws_subnet" "Pub_Subnet2" {
#   vpc_id     = aws_vpc.My_VPC.id
#   cidr_block = "10.0.2.0/24"
#   tags = {
#     Name = "Public_Subnet2_TF"
#   }
# }

# Creating Private Subnets Using Var
resource "aws_subnet" "Private_Subnets" {
    vpc_id = aws_vpc.My_VPC.id
    count = length(var.pri_subnets)
    cidr_block = var.pri_subnets[count.index].cidr_block
    availability_zone = var.pri_subnets[count.index].az
    tags = {
      Name = "Private_Subnet_${count.index+1}_TF"
    }
}
#        Without Using Var
# resource "aws_subnet" "Pri_Subnet1" {
#   vpc_id     = aws_vpc.My_VPC.id
#   cidr_block = "10.0.3.0/24"

#   tags = {
#     Name = "Private_Subnet1_TF"
#   }
# }
# resource "aws_subnet" "Pri_Subnet2" {
#   vpc_id     = aws_vpc.My_VPC.id
#   cidr_block = "10.0.4.0/24"

#   tags = {
#     Name = "Private_Subnet2_TF"
#   }
# }

# Creating IGW in VPC
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.My_VPC.id

  tags = {
    Name = "IGW_Terraform"
  }
}

# elastic Ip for nat gateway
resource "aws_eip" "EIP" {
  domain = "vpc"
  tags = {
    Name = "EIP_TF"
  }
}

# Create NAT GW and attach it to Public subnet
resource "aws_nat_gateway" "NAT_GW" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.Public_Subnets[0].id

  tags = {
    Name = "NAT_GW_TF"
  }
}

#creating Public route table
resource "aws_route_table" "Public_RT" {
    vpc_id = aws_vpc.My_VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }

    tags = {
        Name = "Pub_RT"
    }
}

#associating route table
resource "aws_route_table_association" "Pub_RT_association" {
    count = length(aws_subnet.Public_Subnets)
    subnet_id = aws_subnet.Public_Subnets[count.index].id
    route_table_id = aws_route_table.Public_RT.id
}

# resource "aws_route_table_association" "Pub_RT_association1" {
#     subnet_id = aws_subnet.Pub_Subnet1.id
#     route_table_id = aws_route_table.Public_RT.id
# }
# resource "aws_route_table_association" "Pub_RT_association2" {
#     subnet_id = aws_subnet.Pub_Subnet2.id
#     route_table_id = aws_route_table.Public_RT.id
# }

#creating Private route table
resource "aws_route_table" "Private_RT" {
    vpc_id = aws_vpc.My_VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.NAT_GW.id
    }

    tags = {
        Name = "Pri_RT"
    }
}

#associating route table
resource "aws_route_table_association" "Pri_RT_association" {
    count = length(aws_subnet.Private_Subnets)
    subnet_id = aws_subnet.Private_Subnets[count.index].id
    route_table_id = aws_route_table.Private_RT.id
}

# resource "aws_route_table_association" "Pri_RT_association1" {
#     subnet_id = aws_subnet.Pri_Subnet1.id
#     route_table_id = aws_route_table.Private_RT.id
# }
# resource "aws_route_table_association" "Pri_RT_association2" {
#     subnet_id = aws_subnet.Pri_Subnet2.id
#     route_table_id = aws_route_table.Private_RT.id
# }

# Creating Security Group for FE Instance
resource "aws_security_group" "SG_FE" {
  name   = "FE-sg"
  description = "Security Group for frontend-instance"
  vpc_id = aws_vpc.My_VPC.id
  tags = {
    Name = "SG-FE"
  }
  ingress{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creating Security Group for BE Instance
resource "aws_security_group" "SG_BE" {
  name   = "BE-sg"
  description = "Security Group for backend-instance"
  vpc_id = aws_vpc.My_VPC.id
  tags = {
    Name = "SG-BE"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# # Creating FE Instance
# resource "aws_instance" "FE-instance" {
#     ami                         = data.aws_ami.nginx_AMI.id
#     instance_type               = var.FE_Instance_var.ins_type
#     vpc_security_group_ids      = [aws_security_group.SG_FE.id]
#     associate_public_ip_address = true
#     key_name                    = var.FE_Instance_var.key
#     subnet_id                   = aws_subnet.Public_Subnets[0].id
#     tags = {
#         Name = "Nginx_Instance"
#     }
# }

# # Creating BE Instance
# resource "aws_instance" "BE-instance" {
#     ami                         = data.aws_ami.python_AMI.id
#     instance_type               = var.FE_Instance_var.ins_type
#     vpc_security_group_ids      = [aws_security_group.SG_BE.id]
#     associate_public_ip_address = false
#     key_name                    = "TF_Instance_BE"
#     subnet_id                   = aws_subnet.Private_Subnets[0].id
#     tags = {
#         Name = "Python_Instance"
#     }
# }








