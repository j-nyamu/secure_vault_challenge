#!/bin/bash
#"File name Size in bytes Last modified date Current permissions"
secure_vault="secure_vault/*.txt"
echo "Loading information..."
sleep 5

ls -lch secure_vault/*.txt 2>/dev/null || { echo "No text files found in secure_vault."; exit 0; }

# Prepare report file
report_file="secure_vault/vault_report.txt"
echo "Report generated: $(date)" >> "$report_file"

# Check permissions for security risks: anything > 644 = security risk
# (group/other write or any execute bit present)
risk_found=0

for file in secure_vault/*.txt; do
  [ -e "$file" ] || continue
  perms=$(ls -l "$file" | awk '{print $1}')

  # Check: group write (index 5), other write (index 8), user/group/other exec (indexes 3,6,9)
  if [[ "${perms:5:1}" == "w" || "${perms:8:1}" == "w" || "${perms:3:1}" == "x" || "${perms:6:1}" == "x" || "${perms:9:1}" == "x" ]]; then
    msg="⚠️ SECURITY RISK DETECTED: $file has permissions $perms"
    echo "$msg"
    echo "$msg" >> "$report_file"
    risk_found=1
  fi
done

echo "Scan complete. Checking if any risks were found..."
sleep 2
if [ "$risk_found" -eq 0 ]; then
  msg="No security risks detected."
  echo "$msg"
  echo "$msg" >> "$report_file"
fi
