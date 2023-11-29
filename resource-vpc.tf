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
resource "aws_vpc" "pre_prod" {
    cidr_block = var.preprod_cidr

    tags = {
        Name = "Pre-Production-VPC"
    }
}
resource "aws_subnet" "preprod_app_subnet1" {
    vpc_id = aws_vpc.pre_prod.id
    cidr_block = var.preprod_app_subnet1
    availability_zone = var.az1

    tags = {
        Name = "Pre-Production-Subnet1"
    }
}
resource "aws_subnet" "preprod_app_subnet2" {
    vpc_id = aws_vpc.pre_prod.id
    cidr_block = var.preprod_app_subnet2
    availability_zone = var.az2

    tags = {
        Name = "Pre-Production-Subnet2"
    }
}
resource "aws_subnet" "preprod_db_subnet1" {
    vpc_id = aws_vpc.pre_prod.id
    cidr_block = var.preprod_db_subnet1
    availability_zone = var.az1

    tags = {
        Name = "Pre-Production-Subnet3"
    }
}
resource "aws_subnet" "preprod_db_subnet2" {
    vpc_id = aws_vpc.pre_prod.id
    cidr_block = var.preprod_db_subnet2
    availability_zone = var.az2

    tags = {
        Name = "Pre-Production-Subnet4"
    }
}