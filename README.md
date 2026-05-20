# 🧰 GridPane WordPress Toolkit

A collection of automated server-side scripts for auditing WordPress installations on a GridPane server.

These tools help detect:
* Core file integrity issues
* Suspicious files in uploads
* Plugin checksum mismatches
* General WordPress installation problems

## 📁 Output structure (IMPORTANT)

All scripts generate logs inside an output folder located next to the script itself:

./output/

Each run is saved as a dated log file (YYYYMMDD format):

Example outputs
```
output/wp-core-checks-20260520.txt
output/wp-plugin-checksums-20260520.txt
output/wp-php-uploads-20260520.txt
```

This ensures:

* No overwriting previous scans
* Easy historical comparison
* Per-day audit tracking

## ⚙️ Requirements
GridPane server
WP-CLI via GridPane (gp wp)
Root SSH access
WordPress sites located under:
```
/var/www/*/htdocs
```

## 🧪 Scripts

### wp-core-checks.sh

This file loops through all sites on the Gridpane server to check for core file integrity.
It outputs only:
* Errors
* Warnings.

It uses the following Gridpane WP-CLI command:
```
gp wp domain.com core verify-checksums
```

Detects
* Core file modifications
* Missing or invalid WordPress files
* Installation issues

1. Create the file
```
nano wp-core-checks.sh
```
2. Paste the script code into the file
3. Make script executable
```
chmod +x wp-core-checks.sh
```
4. Run it
```
bash wp-core-checks.sh
```

### find-php-upload-folder.sh

This script checks plugin integrity across all sites.

It uses the following command:
```
find /var/www/domain.com/htdocs/wp-content/uploads/ -type f -name "*.php"
```

Detects
* Modified plugin files
* Tampered plugin code
* Missing plugin files


1. Create the file
```
nano wp-php-upload-folder.sh
```
2. Paste the script code into the file
3. Make script executable
```
chmod +x wp-php-upload-folder.sh
```
4. Run it
```
bash wp-php-upload-folder.sh
```

### wp-plugin-checksums.sh

This script checks plugin integrity across all sites using WP-CLI and compares installed plugins against official WordPress.org checksums.

It uses the following command:
```
gp wp domain.com plugin verify-checksums --all
```
1. Create the file
```
nano wp-plugin-checksums.sh
```
2. Paste the script code into the file
3. Make script executable
```
chmod +x wp-plugin-checksums.sh
```
4. Run it
```
bash wp-plugin-checksums.sh
```

🔐 Security Notes
* These scripts do NOT modify files
* They only scan and report
* Safe for production servers
* Designed for GridPane environment

