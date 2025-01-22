
### main.tf
```
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "${var.name}-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "${var.name}-igw"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true
    availability_zone = var.public_az
    tags = {
      Name ="${var.name}-public-subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr
    map_public_ip_on_launch = true
    availability_zone = var.private_az
    tags = {
      Name ="${var.name}-private-subnet"
    }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.name}-public-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name ="${var.name}-private-rt"
  }
}

resource "aws_route" "internet_accesse" {
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_association" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    Name = "${var.name}-nat-gateway"
  }
}

resource "aws_route" "private_nat_route" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}
```

### outputs.tf
```
output "vpc_id" {
  description = "ID VPC"
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "public subnet id"
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "private subnet id"
  value = aws_subnet.private_subnet.id
}


```

### variables.tf
```
variable "name" {
  description = "name (VPC)"
  type = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "public subnet CIDR"
  type = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "private subnet CIDR"
  type = string
  default = "10.0.2.0/24"
}

variable "public_az" {
  description = "public availability zone"
  type = string
  default = "us-west-2a"
}

variable "private_az" {
  description = "private availability zone"
  type = string
  default = "us-west-2b"
}
```