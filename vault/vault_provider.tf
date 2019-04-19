#Vault provider 


provider "vault" {
#Configure it via environment variables $VAULT_ADDR and $VAULT_TOKEN
} 

resource "vault_aws_secret_backend" "aws" {
  access_key = "xxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxx"

  default_lease_ttl_seconds = "900"
  max_lease_ttl_seconds     = "3600"
}


resource "vault_aws_secret_backend_role" "creds" {
  backend = "${vault_aws_secret_backend.aws.path}"
  name    = "ec2-admin-role"
  credential_type = "iam_user"

 policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:*", "ec2:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}



