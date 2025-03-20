#!/bin/bash

# Capture Terraform destroy output into a log file
cd $3/terraform
terraform destroy -var "access_key=$1" -var "secret_key=$2" -auto-approve > terraform_destroy.log

# Check if Terraform successfully destroyed all resources
if grep -q "Destroy complete! Resources: 0 destroyed." terraform_destroy.log; then
    echo "Terraform destroy SUCCESS: No resources needed deletion."
elif grep -q "Destroy complete! Resources: .* destroyed." terraform_destroy.log; then
    echo "Terraform destroy SUCCESS: All resources deleted."
else
    echo "Terraform destroy FAILED: Some resources were not deleted."
fi
