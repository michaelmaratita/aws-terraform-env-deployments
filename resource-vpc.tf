resource "aws_vpc" "development" {
    cidr_block = var.dev_cidr

    tags = {
        Name = "Development-VPC"
    }
}
resource "aws_subnet" "dev_app_subnet1" {
    vpc_id = aws_vpc.development.id
    cidr_block = var.dev_app_subnet1
    availability_zone = var.az1

    tags = {
        Name = "Development-Subnet-1" 
    }
}
resource "aws_subnet" "dev_app_subnet2" {
    vpc_id = aws_vpc.development.id
    cidr_block = var.dev_app_subnet2
    availability_zone = var.az2

    tags = {
        Name = "Development-Subnet-2"
    }
}
resource "aws_subnet" "dev_db_subnet1" {
    vpc_id = aws_vpc.development.id
    cidr_block = var.dev_db_subnet1
    availability_zone = var.az1

    tags = {
        Name = "Development-Subnet-3"
    }
}
resource "aws_subnet" "dev_db_subnet2" {
    vpc_id = aws_vpc.development.id
    cidr_block = var.dev_db_subnet2
    availability_zone = var.az2

    tags = {
        Name = "Development-Subnet-4"
    }
}
resource "aws_vpc" "test" {
    cidr_block = var.test_cidr

    tags = {
        Name = "Test-VPC"
    }
}
resource "aws_subnet" "test_app_subnet1" {
    vpc_id = aws_vpc.test.id
    cidr_block = var.test_app_subnet1
    availability_zone = var.az1

    tags = {
        Name = "Test-Subnet-1"
    }
}
resource "aws_subnet" "test_app_subnet2" {
    vpc_id = aws_vpc.test.id
    cidr_block = var.test_app_subnet2
    availability_zone = var.az2

    tags = {
        Name = "Test-Subnet-2"
    }
}
resource "aws_subnet" "test_db_subnet1" {
    vpc_id = aws_vpc.test.id
    cidr_block = var.test_db_subnet1
    availability_zone = var.az1

    tags = {
        Name = "Test-Subnet-3"
    }
}
resource "aws_subnet" "test_db_subnet2" {
    vpc_id = aws_vpc.test.id
    cidr_block = var.test_db_subnet2
    availability_zone = var.az2

    tags = {
        Name = "Test-Subnet-4"
    }
}
resource "aws_vpc" "preprod" {
    cidr_block = var.preprod_cidr

    tags = {
        Name = "Pre-Production-VPC"
    }
}
resource "aws_subnet" "preprod_app_subnet1" {
    vpc_id = aws_vpc.preprod.id
    cidr_block = var.preprod_app_subnet1
    availability_zone = var.az1

    tags = {
        Name = "Pre-Production-Subnet1"
    }
}
resource "aws_subnet" "preprod_app_subnet2" {
    vpc_id = aws_vpc.preprod.id
    cidr_block = var.preprod_app_subnet2
    availability_zone = var.az2

    tags = {
        Name = "Pre-Production-Subnet2"
    }
}
resource "aws_subnet" "preprod_db_subnet1" {
    vpc_id = aws_vpc.preprod.id
    cidr_block = var.preprod_db_subnet1
    availability_zone = var.az1

    tags = {
        Name = "Pre-Production-Subnet3"
    }
}
resource "aws_subnet" "preprod_db_subnet2" {
    vpc_id = aws_vpc.preprod.id
    cidr_block = var.preprod_db_subnet2
    availability_zone = var.az2

    tags = {
        Name = "Pre-Production-Subnet4"
    }
}
resource "aws_internet_gateway" "development" {
  vpc_id = aws_vpc.development.id

  tags = {
    Name = "Development-IGW"
  }
}
resource "aws_internet_gateway" "test" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = "Test-IGW"
  }
}
resource "aws_internet_gateway" "preprod" {
  vpc_id = aws_vpc.preprod.id

  tags = {
    Name = "PreProd-IGW"
  }
}
resource "aws_route_table" "Development-Public-Rt" {
  vpc_id = aws_vpc.development.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.development.id
  }

  tags = {
    Name = "Development-Public-rt"
  }
}
resource "aws_route_table" "Test-Public-Rt" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test.id
  }

  tags = {
    Name = "Test-Public-rt"
  }
}
resource "aws_route_table" "PreProd-Public-Rt" {
  vpc_id = aws_vpc.preprod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.preprod.id
  }

  tags = {
    Name = "PreProd-Public-rt"
  }
}
resource "aws_default_route_table" "Development" {
  default_route_table_id = aws_vpc.development.default_route_table_id

  route = []

  tags = {
    Name = "Development-Private-Rt"
  }
}
resource "aws_default_route_table" "Test" {
  default_route_table_id = aws_vpc.test.default_route_table_id

  route = []

  tags = {
    Name = "Test-Private-Rt"
  }
}
resource "aws_default_route_table" "PreProd" {
  default_route_table_id = aws_vpc.preprod.default_route_table_id

  route = []

  tags = {
    Name = "PreProd-Private-Rt"
  }
}
resource "aws_route_table_association" "Development-Public-1" {
  subnet_id      = aws_subnet.dev_app_subnet1.id
  route_table_id = aws_route_table.Development-Public-Rt.id
}
resource "aws_route_table_association" "Development-Public-2" {
  subnet_id      = aws_subnet.dev_app_subnet2.id
  route_table_id = aws_route_table.Development-Public-Rt.id
}
resource "aws_route_table_association" "Development-Private-1" {
  subnet_id      = aws_subnet.dev_db_subnet1.id
  route_table_id = aws_vpc.development.default_route_table_id
}
resource "aws_route_table_association" "Development-Private-2" {
  subnet_id      = aws_subnet.dev_db_subnet2.id
  route_table_id = aws_vpc.development.default_route_table_id
}
resource "aws_route_table_association" "Test-Public-1" {
  subnet_id      = aws_subnet.test_app_subnet1.id
  route_table_id = aws_route_table.Test-Public-Rt.id
}
resource "aws_route_table_association" "Test-Public-2" {
  subnet_id      = aws_subnet.test_app_subnet2.id
  route_table_id = aws_route_table.Test-Public-Rt.id
}
resource "aws_route_table_association" "Test-Private-1" {
  subnet_id      = aws_subnet.test_db_subnet1.id
  route_table_id = aws_vpc.test.default_route_table_id
}
resource "aws_route_table_association" "Test-Private-2" {
  subnet_id      = aws_subnet.test_db_subnet2.id
  route_table_id = aws_vpc.test.default_route_table_id
}
resource "aws_route_table_association" "PreProd-Public-1" {
  subnet_id      = aws_subnet.preprod_app_subnet1.id
  route_table_id = aws_route_table.PreProd-Public-Rt.id
}
resource "aws_route_table_association" "PreProd-Public-2" {
  subnet_id      = aws_subnet.preprod_app_subnet2.id
  route_table_id = aws_route_table.PreProd-Public-Rt.id
}
resource "aws_route_table_association" "PreProd-Private-1" {
  subnet_id      = aws_subnet.preprod_db_subnet1.id
  route_table_id = aws_vpc.preprod.default_route_table_id
}
resource "aws_route_table_association" "PreProd-Private-2" {
  subnet_id      = aws_subnet.preprod_db_subnet2.id
  route_table_id = aws_vpc.preprod.default_route_table_id
}