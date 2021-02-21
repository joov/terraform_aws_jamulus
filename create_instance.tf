data "template_file" "install_script" {
  template = file("install-jamulus.tpl")
  vars = {
    jamulus_rooms = var.jamulus_rooms
    jamulus_max_users = var.jamulus_max_users
    jamulus_hello_text = var.jamulus_hello_text
    jamulus_city = var.jamulus_city
    jamulus_country = var.jamulus_country
    jamulus_version = "6e630f4"
  }
}


resource "aws_instance" "jamulus-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_connections_jamulus.id]
  key_name               = var.ssh_key_name
  user_data              = data.template_file.install_script.rendered

  tags = {
    Name = "jamulus-server"
    Scheduled = "False"
  }
}

output "instance_ip_addr" {
  value       = aws_instance.jamulus-server.public_ip
  description = "The public IP address of the jamulus server instance."
}
