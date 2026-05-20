#!/bin/bash

DATE=$(date +%Y%m%d)
OUTPUT_DIR=/output
OUTPUT_FILE=${OUTPUT_DIR}/php-uploads-${DATE}.txt

mkdir -p "$OUTPUT_DIR"

> "$OUTPUT_FILE"

for site in /var/www/*/htdocs; do

  domain=$(basename "$(dirname "$site")")

  # Skip non-domain folders
  if [[ "$domain" != *.* ]]; then
    continue
  fi

  UPLOADS_PATH="/var/www/$domain/htdocs/wp-content/uploads"

  if [ -d "$UPLOADS_PATH" ]; then

    echo "Scanning: $domain"

    results=$(find "$UPLOADS_PATH" -type f -name "*.php" 2>/dev/null)

    if [[ -n "$results" ]]; then
      {
        echo "DOMAIN: $domain"
        echo "$results"
        echo "---------------------------------"
      } >> "$OUTPUT_FILE"
    fi

  fi

done

echo ""
echo "Finished."
echo "Results saved to:"
echo "$OUTPUT_FILE"