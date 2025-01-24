#!/bin/bash

# Function to execute Terraform commands in a folder
run_terraform() {
    folder=$1
    echo "============================="
    echo "Processing folder: $folder"
    echo "============================="

    if [ -d "$folder" ]; then
        cd "$folder" || exit

        echo "Running: terraform destroy"
        terraform destroy -auto-approve

        echo "Done processing $folder"
        cd - > /dev/null || exit
    else
        echo "Folder $folder does not exist. Skipping."
    fi
}

# Main script
echo "Starting Terraform automation script"

# List of folders to process
folders=("03.bastion-vpn" "02.sg" "01.vpc")

for folder in "${folders[@]}"; do
    run_terraform "$folder"
done

echo "Terraform automation completed!"
