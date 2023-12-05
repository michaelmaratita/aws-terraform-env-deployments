variable "region" {
  type = string
}
variable "availability-zones" {
  type = list(string)
}
variable "instance_metadata_option" {
  type = map(string)
}
variable "vpc_name" {
  type = object({
    Development = object({
      cidr = string
      private_subnet = list(string)
      public_subnet = list(string)
    })
    Test = object({
      cidr = string
      private_subnet = list(string)
      public_subnet = list(string)
    })
    PreProd = object({
      cidr = string
      private_subnet = list(string)
      public_subnet = list(string)
    })
  })
}
variable "public_ec2_name" {
  type = object({
    dev-app-linux1 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
    dev-app-linux2 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
    test-app-linux1 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
    test-app-linux2 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
    pre-prod-app-linux1 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
    pre-prod-app-linux2 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
  })
}
variable "private_ec2_name" {
  type = object({
    dev-db-linux1 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
    dev-db-linux2 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
    test-db-linux1 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
    test-db-linux2 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
    pre-prod-db-linux1 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
    pre-prod-db-linux2 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
  })
}