# Jamulus-AWS

Create a [Jamulus](https://jamulus.io/de/) in the AWS cloud.

Work derived from https://github.com/AvasDream/terraform_aws_jitsi_meet

## What is does

Terraform script to create a Jamulus server on the aws cloud. Everything is automatted. The server can host one or many Jamulus instances, i.e. different rooms.
All rooms are connected to a central server, which is the first room.

The server does not record anything.

## How to use

These steps are one time only:

- Get the requirements (see below)
- Clone the repo
- Configure your settings (see below)
- Call `terraform init` in a shell script inside the repo-folder

Any time you need the server do:

- `terraform apply` to create the server and rooms (answer `yes` if asked to perform these actions)
- Note down the `instance_ip_addr` given at the end of terraforms outputs and give them to your friends. They shoud enter it as `user defined central server` in the settings window and choose `user defined` in the connection window
- `terraform destroy` to completely remove all servers / rooms.

## Requirements

- Terraform is installed and in the current \$PATH
- You know your AWS access and secret keys. [Official Documentation](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)
- You created an AWS SSH Key. [Official Documentation](https://docs.aws.amazon.com/ground-station/latest/ug/create-ec2-ssh-key-pair.html)
- You have created an S3 bucket
- You know your public IP address ([find out](https://www.iplocation.net/find-ip-address))

## Setup

1. create a file `credentials` in `~/.aws` (Unix) or `%HOMEPATH%\.aws` (Windows), see below
2. Create a `terraform.tfvars` file (see below).
3. Copy example content  given below to `terraform.tfvars`.
4. Enter your own data into `terraform.tfvars`.
5. Edit `backend.tf` to fit to your needs. This is neccessary as terraform backend-definitions [cannot contain variables](https://www.terraform.io/docs/language/settings/backends/configuration.html)!)
6. Execute `terraform init` (Use `terraform init -reconfigure` if you changed the backend)
7. Execute `terraform apply`

If everything works right, you get an IP address as an output which is the public address of the jamulus server. After that you still have to wait for 5-10 minutes until the server is ready, as the installation script has to run first.

## Files

### `credentials` file

```properties
[default]
aws_access_key_id = put-your-access-key-id
aws_secret_access_key = put-your-secret-access-key
```

### `terraform.tfvars` file

```properties
aws_region = "eu-central-1"        # AWS Region
instance_type = "t2.large"         # AWS instance type
ssh_key_name = "terraform-key"     # AWS key
ssh_ip_whitelist = ["1.3.3.7/32"]  # Your Computeres public IP address - limits ssh-access to instance
jamulus_max_users = "20"           # Maximum number of connected users
jamulus_rooms = 3                  # Number of rooms on server
jamulus_hello_text = "KottonKlub Room"  # Hello text from Server
jamulus_city = "Solingen"          # City for server info
jamulus_country = "82"             # Country info (82 is Germany)
```
