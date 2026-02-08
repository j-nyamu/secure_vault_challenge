#!/bin/bash

#Check if directory exists, if not print an error message and exit
if [ ! -d "secure_vault" ]; then
  echo "Error: Directory 'secure_vault' does not exist. Please run vault_setup.sh first."
  exit 1
fi 

#check and update file permissions
read -p "Choose file"
echo "1. keys.txt"
echo "2. secrets.txt"
echo "3. logs.txt"
read -p "Enter your choice (1,2 or 3): " file_choice

#Display current permissions of chosen file
case $file_choice in
  1)
    file="secure_vault/keys.txt"
    ;;
  2)
    file="secure_vault/secrets.txt"
    ;;
  3)
    file="secure_vault/logs.txt"
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

echo "Current permissions for $file:"
ls -l $file

#Ask user if they'd like to change permissions
read -p "Do you want to change the permissions of $file? (y/n): " change_perm
if [[ $change_perm =~ ^[Yy]$ ]]; then
  read -p "Enter new permissions in numeric format (e.g., 644, 600) [Press Enter for default]: " new_perm
  # If user pressed Enter without input, apply per-file defaults
  if [ -z "$new_perm" ]; then
    case $file_choice in
      1) new_perm="600" ;;
      2) new_perm="640" ;;
      3) new_perm="64"  ;;
    esac
    echo "No input provided. Applying default permissions: $new_perm"
  fi
  chmod "$new_perm" "$file"
  echo "Permissions for $file updated to $(ls -l $file | awk '{print $1}')."
else
  echo "No changes made to permissions of $file."
fi
#Print final permissions of the file
echo "Final permissions for $file:"
ls -l $file
