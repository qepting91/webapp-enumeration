# mortymap enumeration script

## Overview
mortymap is a Bash script designed for security professionals and penetration testers. It automates the process of domain enumeration, subdomain discovery, live subdomain detection, screenshot capturing of live domains, and comprehensive port scanning using a suite of security tools.

## Features

- Subdomain Discovery: Utilizes subfinder, assetfinder, and amass for thorough subdomain enumeration.
- Live Subdomain Detection: Filters live subdomains using httprobe.
- Screenshot Capturing: Takes screenshots of live subdomains with gowitness.
- Port Scanning: Conducts an exhaustive port scan using nmap.

## Prerequisites

Before using mortymap ensure the following are installed:

- Subfinder
- Assetfinder
- Amass
- Httprobe
- Gowitness
- Nmap

## Installation

Clone the repository: 

`Use `git clone` to clone a repository.`

## Usage

To run the script

`./mortymap.sh <domain>`

## Detailed Workflow

1. Directory Structure Creation: The script first checks for the existence of directories needed for storing data and creates them if they do not exist.
2. Subdomain Enumeration: Runs subfinder, assetfinder, and amass sequentially, storing all found subdomains in a text file.
3. Live Subdomain Detection: Processes the list of found subdomains to identify which ones are live.
4. Screenshot Capturing: Uses gowitness to capture screenshots of the live subdomains.
5. Port Scanning: Performs an exhaustive port scan on the live subdomains using nmap.

## Contributing
Contributions to mortymap are welcome. Please adhere to the following guidelines:

- Fork the repository.
- Create a new branch for your feature.
- Commit your changes.
- Push to the branch and open a pull request.
