
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

variable "jamulus_rooms" {
  description = "Numbers of jamulus rooms on server"
  default = 1
}

variable "jamulus_hello_text" {
  description = "Hello Text for Jamulus rooms"
  default = "My Jamulus Room"
}

variable "jamulus_city" {
  description = "City of jamulus server"
  default = "Frankfurt"
}


variable "jamulus_country" {
  description = "Country of jamulus server"
  default = "82"
}
