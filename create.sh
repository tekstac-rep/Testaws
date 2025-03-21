#!/bin/bash

ACCESS_KEY="$1"
SECRET_KEY="$2"

# Navigate to Terraform directory
cd terraform || { echo "Terraform directory not found!"; exit 1; }

# Remove old Terraform state (force fresh start)
rm -rf .terraform terraform.tfstate terraform.tfstate.backup

# Initialize Terraform
terraform init

# Start Terraform apply and run it in the background
terraform apply -var "access_key=$ACCESS_KEY" -var "secret_key=$SECRET_KEY" -auto-approve > terraform.log 2>&1 &

# Capture Terraform process ID
TF_PID=$!

echo "Waiting for Terraform to complete..."
wait "$TF_PID"  # Waits for Terraform process to complete

# Check Terraform execution status
if grep -q "Apply complete! Resources: .* added, 0 changed, 0 destroyed." terraform.log; then
    echo "Terraform Deployment: SUCCESS"
else
    echo "Terraform Deployment: FAILURE"
    cat terraform.log  # Print logs for debugging if failure occurs
fi
