#!/bin/bash
# Create directory "secure_vault"
mkdir secure_vault

# .txt files being created
echo "Welcome" > secure_vault/keys.txt
echo "Welcome" > secure_vault/secrets.txt
echo "Welcome" > secure_vault/logs.txt

# If files and/or directory exist, print message and continue
if [ -d secure_vault ] || [ -f secure_vault/keys.txt ] || [ -f secure_vault/secrets.txt ] || [ -f secure_vault/logs.txt ]; then
    echo "Files and/or directory have been created, continuing with the script."
fi

#Print success message after script is run
echo "Directory 'secure_vault' and text files created successfully."
ls -l secure_vault
