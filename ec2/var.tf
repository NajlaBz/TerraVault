#AWS Provider variables

variable "region" {
  default = "eu-west-1"
}




#EC2 related variables

variable "ami_id" {
  description = "The ID of the AMI to run in this ec2: Latest ubuntu version valid for eu-west-1 region"
  default     = "ami-bbc542c8"
}

variable "instance_type" {
  description = "The type of EC2 Instances."
  default     = "t2.micro"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "Test"
}

