
terraform {
  backend "s3" {
    bucket = "tfstate-jitsi"
    key    = "jamulus"
    region = "eu-central-1"
  }
}
