# TerraVault
In the present work, we define 2 workspaces:

*****Provider workspace

That's where the AWS backend is configured and so the role attached to the IAM credentials to be created.

*****Consummer workspace 

That's where the credentials will be generated following the role already defined in the provider workspace

In the consummer workspace we aim to generate IAM credentials on demand and with those credentials we will be creating an EC2 instance.

When creating the EC2 instance, we would like to generate and store the key pairs in vault.
