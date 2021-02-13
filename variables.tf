
variable "aws_region" {
  description = "Region where the instance should be located"
  default = "eu-central-1"
}
variable "instance_type" {
  description = "Instance type to launch"
  default = "t2.micro"
}
variable "ssh_key_name" {
  description = "Name of the SSH key"
  default = "terraform-key"
}
variable "ssh_ip_whitelist" {
  description = "All allowed ingress IPs"
  default = ["1.3.3.7/32"]
}

variable "jamulus_max_users" {
  description = "Max Numbers of jamulus users"
  default = "10"
}