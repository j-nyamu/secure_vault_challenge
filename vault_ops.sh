#!/bin/bash
#Menu options
while true; do
  echo "Select an option:"
  echo "1) Add Secret"
  echo "2) Update Secret"
  echo "3) Add Log Entry"
  echo "4) Access Keys"
  echo "5) Exit"
  read -p "Enter your choice: " choice

  case "$choice" in
    1)
      echo "Add Secret" #Append a new secret to secrets.txt
      read -p "Enter the secret to add: " new_secret
        echo "$new_secret" >> secure_vault/secrets.txt
      ;;
    2)
      echo "Update Secret" #Replace an existing secret 
        read -p "Enter the secret to update: "
        read -p "Enter the new secret: " updated_secret
        sed -i.bak "s/$new_secret/$updated_secret/" secure_vault/secrets.txt
      ;;
    3)
      echo "Add Log Entry" #Add a timestamped log entry to logs.txt
        read -p "Enter log entry: " log_entry
        echo "$(date): $log_entry" >> secure_vault/logs.txt
      ;;
    4)
      echo "ACCESS DENIED 🚫" #Never display keys.txt 
      ;;
    5)
      echo "Exiting . . ."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please select 1, 2, 3, 4, or 5."
      ;;
  esac
done