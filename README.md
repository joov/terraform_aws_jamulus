# Jamulus-AWS

Create a [Jamulus](https://jamulus.io/de/) in the AWS cloud.

Work derived from https://github.com/AvasDream/terraform_aws_jitsi_meet

## Requirements

- Terraform is installed and in the current \$PATH
- You know your AWS access and secret keys. [Official Documentation](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)
- You created an AWS SSH Key. [Official Documentation](https://docs.aws.amazon.com/ground-station/latest/ug/create-ec2-ssh-key-pair.html)
- You have created an S3 bucket
- You know your public IP address ([find out](https://www.iplocation.net/find-ip-address))

## Setup

1. create a file `credentials` in `~/.aws` (Unix) or `%HOMEPATH%\.aws` (Windows), see below
2. Create a `terraform.tfvars` file (see below).
3. Copy example Content in Variables file.
4. Enter your own data.
5. Edit `backend.tf` to suit your needs. The S3-Bucket has to be present before running terraform (unfortunately backend-definition [cannot contain variables](https://www.terraform.io/docs/language/settings/backends/configuration.html)!)
6. Execute `terraform init` (Use `terraform init -reconfigure` if you changed the backend)
7. Execute `terraform apply`

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
```

