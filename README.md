# Gridpane-WP-Toolkit

## wp-core-checks.sh

This file loops through all sites on the Gridpane server to check for core file integrity, then outputs a file with Errors and Warnings.

It uses the following Gridpane WP-CLI command:
```
gp wp domain.com core verify-checksums
```

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

## find-php-upload-folder.sh

This script searches WordPress upload directories for suspicious PHP files.
It helps identify potential malicious uploads.

It uses the following command:
find /var/www/domain.com/htdocs/wp-content/uploads/ -type f -name "*.php"


1. Create the file
```
nano wp-php-uploads.sh
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

## wp-plugin-checksums.sh

This script searchs WP Plugins and does a checksum check and compares them with repo plugins to make sure they are real

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