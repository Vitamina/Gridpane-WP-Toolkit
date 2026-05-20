# Gridpane-WP-Toolkit

## wp-core-checks.sh

This file loops through all sites on the Gridpane server to check for core file integrity, then outputs a file with Errors and Warnings.

It uses the following Gridpane WP-CLI command:
```
gp wp domain.com core verify-checksums
```

1. Create the file
```
nano ~/wp-core-checks.sh
```
2. Paste the script code into the file
3. Make script executable
```
chmod +x ~/wp-core-checks.sh
```
4. Run it
```
~/wp-core-checks.sh
```