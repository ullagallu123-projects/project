#!/bin/bash

# Function to execute Terraform commands in a folder
run_terraform() {
    folder=$1
    echo "============================="
    echo "Processing folder: $folder"
    echo "============================="

    if [ -d "$folder" ]; then
        cd "$folder" || exit

        echo "Running: terraform init"
        terraform init -reconfigure

        echo "Running: terraform fmt"
        terraform fmt 

        echo "Running: terraform validate"
        terraform validate

        echo "Running: terraform plan"
        terraform plan 

        echo "Running: terraform apply"
        terraform apply -auto-approve

        echo "Done processing $folder"
        cd - > /dev/null || exit
    else
        echo "Folder $folder does not exist. Skipping."
    fi
}

# Main script
echo "Starting Terraform automation script"

# List of folders to process
folders=("01.vpc" "02.sg" "03.bastion-vpn" "04.rds" "05.internal-external")

for folder in "${folders[@]}"; do
    run_terraform "$folder"
done

echo "Terraform automation completed!"
