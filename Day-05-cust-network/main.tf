# vpc creation
resource "aws_vpc" "Dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Cust-vpc"
    }
  
}
# subnet creation public
resource "aws_subnet" "pub" {
    vpc_id = aws_vpc.Dev.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "Pub-sub"
    }
}
# subnet creation private
resource "aws_subnet" "pvt" {
    vpc_id = aws_vpc.Dev.id
    cidr_block = "10.0.2.0/24"
    tags = {
      Name = "pvt-sub"
    }
}
# internet gateway creation
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.Dev.id

  
}
# public route table creation and edit routes
resource "aws_route_table" "dev" {
    vpc_id = aws_vpc.Dev.id
    tags = {
      Name = "pub-rt"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
  
}
# subnet association
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.pub.id
    route_table_id = aws_route_table.dev.id
    
  
}
# creation of ellastic ip
resource "aws_eip" "nat-ip" {
    domain = "vpc"
  
}
# nat gateway creation
resource "aws_nat_gateway" "NAT" {
    allocation_id = aws_eip.nat-ip.id
    subnet_id = aws_subnet.pub.id
    tags = {
      Name = "pvt-nat"
    }
    depends_on = [ aws_internet_gateway.name]

  
}
# creation of private route table and edit routes
resource "aws_route_table" "pvt-RT" {
    vpc_id = aws_vpc.Dev.id
    tags = {
      Name = "pvt-RT"
    }
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.NAT.id
    }
  
}
# private subnet association
resource "aws_route_table_association" "pvt-rt" {
    subnet_id = aws_subnet.pvt.id
    route_table_id = aws_route_table.pvt-RT.id
  
}
# creation of security group
resource "aws_security_group" "name" {
    name = "allow-ttls"
    vpc_id = aws_vpc.Dev.id
    tags = {
      Name = "dev-sg"
    }
    ingress {
        description = "HTTP"
        from_port = "80"
        to_port = "80"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"  # it indicates all protocol
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}
# public ec2 or server creation
resource "aws_instance" "name" {
    ami = "ami-0b46816ffa1234887"
    instance_type = "t3.micro"
    associate_public_ip_address = "true"
    subnet_id = aws_subnet.pub.id
    vpc_security_group_ids = [aws_security_group.name.id]
    tags = {
        Name = "dheeraj"
    }
  
}
# private ec2/server creation
resource "aws_instance" "pvt-ec2" {
    ami = "ami-0b46816ffa1234887"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.pvt.id
    vpc_security_group_ids = [aws_security_group.name.id]
    tags = {
        Name = "dheeraj-pvt"
    }
  
}