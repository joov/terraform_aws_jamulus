resource "aws_security_group" "allow_connections_jamulus" {
  name        = "onnections_jamulus"
  description = "Allow TLS inbound traffic for ssh but only for the host PCs external IP."

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_ip_whitelist
  }
  ingress {
    from_port   = 22124
    to_port     = 22124 + var.jamulus_rooms - 1
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_connections_jamulus"
  }
}
