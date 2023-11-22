resource "aws_instance" "dev-app1" {
    ami = "ami-06e4ca05d431835e9"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.development_subnet.id
    key_name = "test_linux"
    root_block_device {
      delete_on_termination = true
      encrypted = true
      volume_size = 10

      tags = {
        Name = "dev-app1"
        Environment = "Development"
      }
    }

    tags = {
      Name = "Dev-App-Linux"
      Environment = "Development"
    }
  
}