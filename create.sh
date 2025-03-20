#!/bin/bash

###Terraform Initialize####
cd terraform
terraform init
terraform apply -var "access_key=$1" -var "secret_key=$2" -auto-approve > terraform/terraform.log

# Check if Terraform execution was successful
if grep -q "Apply complete! Resources: .* added, 0 changed, 0 destroyed." terraform.log; then
    echo "Success"
else
    echo "Failure"
fi
