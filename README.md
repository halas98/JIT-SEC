# JIT-SEC Pentest Recon Script

## Overview

JIT-SEC Pentest Recon Script is a Bash script designed for basic information gathering, scanning, and reconnaissance during penetration testing. It includes common tools like Nmap, enum4linux, SNMPwalk, whois, DNS zone transfer, and SSL certificate checking.

## Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/halas98/JIT-SEC_Pentest_Recon.git

2. Navigate to the script directory:

   cd JIT-SEC_Pentest_Recon

3. Make the script executable:

   chmod +x JIT-SEC_recon.sh

4. Run the script with the target IP as an argument:

   ./JIT-SEC_recon.sh target_ip

Features
Nmap scan with basic and detailed options
DNS Enumeration with enum4linux
SNMP Enumeration with snmpwalk
Whois lookup
DNS Zone Transfer with dig
SSL Certificate Information

Output
Results will be saved in a directory named JIT-SEC_results within the script directory. The output files include:

nmap_scan.txt
nmap_detailed_scan.txt
enum4linux.txt
snmp_enum.txt
whois.txt
dns_zone_transfer.txt
ssl_certificate.txt

Disclaimer

Ensure you have explicit permission before using this script for penetration testing. Unauthorized access to systems is illegal and against ethical guidelines.

