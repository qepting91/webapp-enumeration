#!/bin/bash
# Exit the script if any command returns a non-zero exit code
set -e

# Function to validate the domain format
validate_domain() {
    if [[ $1 =~ ^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        echo "Invalid domain format. Please enter a valid domain."
        exit 1
    fi
}

# Capture the first argument as the domain and validate it
domain=$1
validate_domain $domain

# Define color codes for output
RED="\033[1;31m"
RESET="\033[0m"

# Define paths for storing subdomains, screenshots, and scans
subdomain_path=$domain/subdomains 
screenshot_path=$domain/screenshots
scan_path=$domain/scans

# Check if the main directory for the domain exists; if not, create it
if [ ! -d "$domain" ]; then
    mkdir $domain
fi

# Check if the subdomain directory exists; if not, create it
if [ ! -d "$subdomain_path" ]; then
    mkdir $subdomain_path
fi

# Check if the screenshot directory exists; if not, create it
if [ ! -d "$screenshot_path" ]; then
    mkdir $screenshot_path
fi

# Check if the scan directory exists; if not, create it
if [ ! -d "$scan_path" ]; then
    mkdir $scan_path
fi

# Use Subfinder to find subdomains and save the results
echo -e "${RED}[+] Subfinder ${RESET}"
subfinder -d $domain > $subdomain_path/found.txt

# Use Assetfinder for additional subdomain discovery and append the results
echo -e "${RED}[+] Assetfinder ${RESET}"
assetfinder $domain | grep $domain >> $subdomain_path/found.txt

# Use Amass for enumeration and append the results
echo -e "${RED}[+] Amass ${RESET}"
amass enum -d $domain >> $subdomain_path/found.txt

# Filter and check for live subdomains from the list of found subdomains
echo -e "${RED}[+] Aliveeeeee ${RESET}"
cat $subdomain_path/found.txt | frep $domain | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///' | tee -a $subdomain_path/alive.txt

# Take screenshots of alive subdomains
echo -e "${RED}[+] Taking Screenshots of alive subdomains ${RESET}"
gowitness file -f $subdomain_path/alive.txt -P $screenshot_path/ --no-http

# Perform an NMAP scan on the live subdomains and save the results
echo -e "${RED}[+] NMAP on the live ones ${RESET}"
nmap iL $subdomain_path/alive.txt -T4 -p- -oN $scan_path/nmap.txt