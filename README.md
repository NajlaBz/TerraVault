# TerraVault
In the present work, we define 2 workspaces:

*Provider workspace

That's where the AWS backend is configured and so the role attached to the IAM credentials to be created.

*Consumer workspace 

That's where the credentials will be generated following the role already defined in the provider workspace

In the Consumer  workspace we aim to generate IAM credentials on demand and with those credentials we will be creating an EC2 instance.

When creating the EC2 instance, we would like to generate and store the key pairs in vault.

PS : Configure the Vault credentials (address and Token) and the AWS backend (access_key and secret_key)

Steps to execute any terraform code:
Step 1: Run command "terraform init" to init configuration workspace
Step 2: Run command "terraform plan" to see output which is going to be executed.
Step 5: Run command "terraform apply" to actually create any resource defined with terraform
Step 6: Run command "terraform destroy" to destroy created resources.
