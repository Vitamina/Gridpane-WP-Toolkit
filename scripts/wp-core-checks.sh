#!/bin/bash

DATE=$(date +%Y%m%d)
OUTPUT_DIR="$(dirname "$0")/output"
OUTPUT_FILE=${OUTPUT_DIR}/bad-checksums-${DATE}.txt

mkdir -p "$OUTPUT_DIR"

# Clear previous results
> "$OUTPUT_FILE"

# Collect valid sites first
sites=()
for site in /var/www/*/htdocs; do
  domain=$(basename "$(dirname "$site")")

  # Skip non-domain folders
  if [[ "$domain" != *.* ]]; then
    continue
  fi

  sites+=("$site")
done

total=${#sites[@]}
current=0

draw_progress () {
  local progress=$1
  local total=$2
  local width=40

  local percent=$(( progress * 100 / total ))
  local filled=$(( progress * width / total ))

  printf "\r["
  printf "%0.s#" $(seq 1 $filled)
  printf "%0.s-" $(seq 1 $((width - filled)))
  printf "] %d%% (%d/%d)" "$percent" "$progress" "$total"
}

echo "Starting checksum verification for $total sites..."

for site in "${sites[@]}"; do
  current=$((current + 1))

  domain=$(basename "$(dirname "$site")")

  echo -e "\nChecking: $domain"

  result=$(gp wp "$domain" core verify-checksums 2>&1)

  echo "$result"

  issues=$(echo "$result" | grep -E "Error:|Warning:")

  if [[ -n "$issues" ]]; then
    {
      echo "DOMAIN: $domain"
      echo "$issues"
      echo "---------------------------------"
    } >> "$OUTPUT_FILE"
  fi

  echo "---------------------------------"

  draw_progress "$current" "$total"
done

echo ""
echo "Finished."
echo "Issues saved to:"
echo "$OUTPUT_FILE"