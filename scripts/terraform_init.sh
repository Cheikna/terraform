#!bin/bash
touch -a terraform.log

terraform init

terraform apply -auto-approve