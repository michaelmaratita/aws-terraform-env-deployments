resource "aws_instance" "test_linux" {
	ami = "ami-06e4ca05d431835e9"
	instance_type = "t2.micro"
	subnet_id = aws_subnet.development_subnet.id
	key_name = "test_linux"
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "test_linux"
			Environment = "{test-app-linux, root_vol}"
		}
	}

	tags = {
		Name = "test_linux"
		Environment = "Development"
	}
}

resource "aws_instance" "test_2" {
	ami = "ami-06e4ca05d431835e9"
	instance_type = "c5.xlarge"
	subnet_id = aws_subnet.development_subnet.id
	key_name = "test_linux"
	root_block_device {
		delete_on_termination = true
		encrypted = true
		volume_size = 10

		tags = {
			Name = "test_2"
			Environment = "dev-app-linux"
		}
	}

	tags = {
		Name = "test_2"
		Environment = "Development"
	}
}