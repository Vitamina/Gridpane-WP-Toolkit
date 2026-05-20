#!/bin/bash

DATE=$(date +%Y%m%d)
OUTPUT_DIR="$(dirname "$0")/output"
OUTPUT_FILE=${OUTPUT_DIR}/bad-checksums-${DATE}.txt

# Clear previous results
> "$OUTPUT_FILE"

for site in /var/www/*/htdocs; do

  domain=$(basename "$(dirname "$site")")

  # Skip non-domain folders
  if [[ "$domain" != *.* ]]; then
    continue
  fi

  echo "Checking: $domain"

  result=$(gp wp "$domain" core verify-checksums 2>&1)

  echo "$result"

  # Extract warnings/errors only
  issues=$(echo "$result" | grep -E "Error:|Warning:")

  # If issues found, save them
  if [[ -n "$issues" ]]; then
    {
      echo "DOMAIN: $domain"
      echo "$issues"
      echo "---------------------------------"
    } >> "$OUTPUT_FILE"
  fi

  echo "---------------------------------"

done

echo ""
echo "Finished."
echo "Issues saved to:"
echo "$OUTPUT_FILE"