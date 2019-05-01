# AWS Provider 

provider "aws" {

  access_key = "${data.vault_aws_access_credentials.creds.access_key}"
  secret_key = "${data.vault_aws_access_credentials.creds.secret_key}"
  token = "${data.vault_aws_access_credentials.creds.security_token}"
  region	 = "${var.region}"
}

#Vault provider 


provider "vault" {
  #Configure it via environment variables $VAULT_ADDR and $VAULT_TOKEN
} 


data "vault_aws_access_credentials" "creds" {
  backend = "aws"
  role    = "ec2-admin-role"
}

resource "vault_generic_secret" "key_pairs" {

  path = "secret/key_pairs"
  data_json = "${jsonencode(map(aws_key_pair.generated.key_name,local_file.private_key_pem.content))}"
}


#Key pair generation and locally storing it

resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096

}


resource "aws_key_pair" "generated" {
  key_name   = "KeYYYY"
  depends_on = ["tls_private_key.generated"]
  public_key = "${tls_private_key.generated.public_key_openssh}"

  
}

#Storing the key pair via local file
resource "local_file" "private_key_pem" {

  content    = "${tls_private_key.generated.private_key_pem}"
  depends_on = ["tls_private_key.generated"]
  filename   =  "/home/ubuntu/storedkeys/KeYYYY.pem"
  provisioner "local-exec" {
    command = "chmod 0600 /home/ubuntu/storedkeys/KeYYYY.pem "
  }
}

#Security groups : ONE RULE TO ALLOW SSH TRAFIC
resource "aws_security_group" "external" {
  name        = "allow_all"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "Environment" = "${var.environment_tag}"
  }
}

# EC2 definition
resource "aws_instance" "test" {
  ami      = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.external.id}"]  
  key_name        = "${aws_key_pair.generated.key_name}"

  tags {
    Name = "${var.environment_tag}"
  }
}




