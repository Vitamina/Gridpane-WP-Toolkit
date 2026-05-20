#!/bin/bash

DATE=$(date +%Y%m%d)
OUTPUT_DIR="$(dirname "$0")/output"
OUTPUT_FILE=${OUTPUT_DIR}/plugin-checksums-${DATE}.txt

mkdir -p "$OUTPUT_DIR"

> "$OUTPUT_FILE"

for site in /var/www/*/htdocs; do

  domain=$(basename "$(dirname "$site")")

  # Skip non-domain folders
  if [[ "$domain" != *.* ]]; then
    continue
  fi

  echo "Checking plugins: $domain"

  result=$(gp wp "$domain" plugin verify-checksums --all 2>&1)

  echo "$result"

  # Capture anything NOT successful
  issues=$(echo "$result" | grep -E "Error:|Warning:|does not|not verified|failed")

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
echo "Results saved to:"
echo "$OUTPUT_FILE"