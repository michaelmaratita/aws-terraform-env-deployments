resource "aws_vpc" "development" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "development"
    }
}
resource "aws_subnet" "development_subnet" {
    vpc_id = aws_vpc.development.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-1a"

    tags = {
        Name = "development"
    }
}
resource "aws_vpc" "test" {
    cidr_block = "172.16.0.0/16"

    tags = {
        Name = "test"
    }
}
resource "aws_subnet" "test_subnet" {
    vpc_id = aws_vpc.test.id
    cidr_block = "172.16.1.0/24"
    availability_zone = "us-west-1a"

    tags = {
        Name = "test"
    }
}
resource "aws_vpc" "pre_prod" {
    cidr_block = "192.168.0.0/16"

    tags = {
        Name = "pre_prod"
    }
}
resource "aws_subnet" "pre_prod_subnet" {
    vpc_id = aws_vpc.pre_prod.id
    cidr_block = "192.168.1.0/24"
    availability_zone = "us-west-1a"

    tags = {
        Name = "pre_prod"
    }
}