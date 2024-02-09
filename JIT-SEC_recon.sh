#!/bin/bash

# JIT-SEC - Pentest Recon Script

# Usage: ./JIT-SEC_recon.sh target_ip

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 target_ip"
    exit 1
fi

TARGET_IP=$1
OUTPUT_DIR="JIT-SEC_results"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# JIT-SEC Banner
echo "------------------------------------"
echo "      JIT-SEC - Pentest Recon        "
echo "------------------------------------"

# Nmap scan
echo "Running Nmap scan..."
nmap -sS -sV -p- -oN "$OUTPUT_DIR/nmap_scan.txt" "$TARGET_IP"

# DNS Enumeration with enum4linux
echo "Running enum4linux..."
enum4linux "$TARGET_IP" > "$OUTPUT_DIR/enum4linux.txt"

# SNMP Enumeration with snmpwalk
echo "Running SNMP enumeration..."
snmpwalk -v2c -c public "$TARGET_IP" > "$OUTPUT_DIR/snmp_enum.txt"

# Whois lookup
echo "Running whois lookup..."
whois "$TARGET_IP" > "$OUTPUT_DIR/whois.txt"

# DNS Zone Transfer with dig
echo "Running DNS zone transfer..."
dig axfr @"$TARGET_IP" > "$OUTPUT_DIR/dns_zone_transfer.txt"

# SSL Certificate Information
echo "Checking SSL certificate..."
openssl s_client -showcerts -connect "$TARGET_IP":443 </dev/null 2>/dev/null | openssl x509 -noout -text > "$OUTPUT_DIR/ssl_certificate.txt"

echo "Reconnaissance completed. Results saved in $OUTPUT_DIR"

