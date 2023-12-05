provider "aws" {
    region = var.region  
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  for_each = var.vpc_name
  name = each.key
  cidr = each.value.cidr
  azs             = var.availability-zones
  private_subnets = each.value.private_subnet
  public_subnets  = each.value.public_subnet
  enable_dns_hostnames = false
  enable_dns_support = false

  tags = {
    Terraform = "true"
    Environment = each.key
  }
}
module "public_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = var.public_ec2_name

  name = "${each.key}"

  ami                         = each.value.ami
  associate_public_ip_address = each.value.public_ip
  availability_zone           = each.value.availability_zone
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  monitoring                  = each.value.monitoring
  root_block_device           = [each.value.root_volume]
  # vpc_security_group_ids      = ["sg-12345678"]
  subnet_id                   = module.vpc[each.value.environment].public_subnets[each.value.subnet_id]
  metadata_options            = var.instance_metadata_option
  tags = {
    Terraform   = "true"
    Environment = each.value.environment
  }
}
module "private_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = var.private_ec2_name

  name = "${each.key}"

  ami                         = each.value.ami
  associate_public_ip_address = each.value.public_ip
  availability_zone           = each.value.availability_zone
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  monitoring                  = each.value.monitoring
  root_block_device           = [each.value.root_volume]
  # vpc_security_group_ids      = ["sg-12345678"]
  subnet_id                   = module.vpc[each.value.environment].private_subnets[each.value.subnet_id]
  metadata_options            = var.instance_metadata_option
  tags = {
    Terraform   = "true"
    Environment = each.value.environment
  }
}
