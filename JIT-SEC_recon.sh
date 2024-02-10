# JIT-SEC - Pentest Recon Script

# Usage: ./JIT-SEC_recon.sh target_ip

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 target_ip"
    exit 1
fi

TARGET_IP=$1
OUTPUT_DIR="JIT-SEC_results_$TARGET_IP"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Enlarged JIT-SEC Banner
echo "--------------------------------------------------------"
echo "         JIT-SEC - Pentest Reconnaissance Script         "
echo "--------------------------------------------------------"

# Function to check and install a tool
check_and_install_tool() {
    local tool_name=$1
    command -v "$tool_name" >/dev/null 2>&1 || {
        echo "Installing $tool_name..."
        sudo apt-get install -y "$tool_name" || {
            echo "Error: Unable to install $tool_name. Please install it manually."
            exit 1
        }
    }
}

# Check and install Nmap
check_and_install_tool "nmap"

# Check and install enum4linux
check_and_install_tool "enum4linux"

# Check and install snmpwalk
check_and_install_tool "snmpwalk"

# Check and install whois
check_and_install_tool "whois"

# Check and install dig
check_and_install_tool "dnsutils"

# Check and install openssl
check_and_install_tool "openssl"

# Nmap scan
echo "Running Nmap scan..."
nmap -sS -sV -p- -oN "$OUTPUT_DIR/nmap_scan.txt" "$TARGET_IP"

# More detailed Nmap scan (add any additional Nmap options you need)
echo "Running detailed Nmap scan..."
nmap -A -oN "$OUTPUT_DIR/nmap_detailed_scan.txt" "$TARGET_IP"

# DNS Enumeration with enum4linux
echo "Running enum4linux..."
enum4linux "$TARGET_IP" > "$OUTPUT_DIR/enum4linux.txt"

# SNMP Enumeration with snmpwalk
echo "Running SNMP enumeration..."
snmpwalk -v2c -c public "$TARGET_IP" > "$OUTPUT_DIR/snmp_enum.txt"
snmp_status=$?

if [ $snmp_status -eq 0 ]; then
    echo "SNMP enumeration successful."
else
    echo "SNMP enumeration failed. Check SNMP configuration on the target system."
fi

# Whois lookup
echo "Running whois lookup..."
whois "$TARGET_IP" > "$OUTPUT_DIR/whois.txt"

# DNS Zone Transfer with dig
echo "Running DNS zone transfer..."
dig axfr @"$TARGET_IP" > "$OUTPUT_DIR/dns_zone_transfer.txt"

# SSL Certificate Information
echo "Checking SSL certificate..."
openssl s_client -showcerts -connect "$TARGET_IP":443 </dev/null 2>/dev/null | openssl x509 -noout -text > "$OUTPUT_DIR/ssl_certificate.txt"
ssl_status=$?

if [ $ssl_status -eq 0 ]; then
    echo "SSL certificate check successful."
else
    echo "SSL certificate check failed. Check SSL configuration on the target system."
fi

echo "Reconnaissance completed. Results saved in $OUTPUT_DIR"
