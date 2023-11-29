resource "aws_instance" "dev-app-linux1" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.dev_app_subnet1.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "dev-app-linux1"
			Environment  = "Development"
		}
	}

	tags = {
		Name = "dev-app-linux1"
		Environment = "Development"
	}
}

resource "aws_instance" "dev-app-linux2" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.dev_app_subnet2.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "dev-app-linux2"
			Environment  = "Development"
		}
	}

	tags = {
		Name = "dev-app-linux2"
		Environment = "Development"
	}
}

resource "aws_instance" "test-app-linux1" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.test_app_subnet1.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "test-app-linux1"
			Environment  = "Test"
		}
	}

	tags = {
		Name = "test-app-linux1"
		Environment = "Test"
	}
}

resource "aws_instance" "test-app-linux2" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.test_app_subnet2.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "test-app-linux2"
			Environment  = "Test"
		}
	}

	tags = {
		Name = "test-app-linux2"
		Environment = "Test"
	}
}

resource "aws_instance" "pre-prod-app-linux1" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.preprod_app_subnet1.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "pre-prod-app-linux1"
			Environment  = "PreProd"
		}
	}

	tags = {
		Name = "pre-prod-app-linux1"
		Environment = "PreProd"
	}
}

resource "aws_instance" "pre-prod-app-linux2" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.preprod_app_subnet2.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "pre-prod-app-linux2"
			Environment  = "PreProd"
		}
	}

	tags = {
		Name = "pre-prod-app-linux2"
		Environment = "PreProd"
	}
}

resource "aws_instance" "dev-db-linux1" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.dev_db_subnet1.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "dev-db-linux1"
			Environment  = "Development"
		}
	}

	tags = {
		Name = "dev-db-linux1"
		Environment = "Development"
	}
}

resource "aws_instance" "dev-db-linux2" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.dev_db_subnet2.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "dev-db-linux2"
			Environment  = "Development"
		}
	}

	tags = {
		Name = "dev-db-linux2"
		Environment = "Development"
	}
}

resource "aws_instance" "test-db-linux1" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.test_db_subnet1.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "test-db-linux1"
			Environment  = "Test"
		}
	}

	tags = {
		Name = "test-db-linux1"
		Environment = "Test"
	}
}

resource "aws_instance" "test-db-linux2" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.test_db_subnet2.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "test-db-linux2"
			Environment  = "Test"
		}
	}

	tags = {
		Name = "test-db-linux2"
		Environment = "Test"
	}
}

resource "aws_instance" "pre-prod-db-linux1" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.preprod_db_subnet1.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "pre-prod-db-linux1"
			Environment  = "PreProd"
		}
	}

	tags = {
		Name = "pre-prod-db-linux1"
		Environment = "PreProd"
	}
}

resource "aws_instance" "pre-prod-db-linux2" {
	ami = var.linux_ami
	instance_type = "t2.micro"
	subnet_id = aws_subnet.preprod_db_subnet2.id
	key_name = var.linux_key
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "pre-prod-db-linux2"
			Environment  = "PreProd"
		}
	}

	tags = {
		Name = "pre-prod-db-linux2"
		Environment = "PreProd"
	}
}