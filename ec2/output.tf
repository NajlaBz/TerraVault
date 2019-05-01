

output "public_ip" {
  value = "${aws_instance.test.public_ip}"
}


output "connect" {
  value = "ssh -i ${local_file.private_key_pem.filename} ubuntu@${aws_instance.test.public_dns}"
}
