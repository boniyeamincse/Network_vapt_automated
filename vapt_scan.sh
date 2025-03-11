#!/bin/bash

# Network Range (Modify as needed)
NETWORK="10.24.0.0/16"
OUTPUT_DIR="vapt_results"
mkdir -p $OUTPUT_DIR

# Timestamp
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$OUTPUT_DIR/vapt_scan_$DATE.log"
echo "Starting Network Security VAPT Scan on $NETWORK" | tee -a $LOG_FILE

# 1. Host Discovery
echo "[+] Scanning for live hosts..." | tee -a $LOG_FILE
nmap -sn $NETWORK -oG $OUTPUT_DIR/live_hosts.txt
cat $OUTPUT_DIR/live_hosts.txt | grep "Up" | awk '{print $2}' > $OUTPUT_DIR/active_ips.txt

# 2. Port Scanning
echo "[+] Scanning open ports..." | tee -a $LOG_FILE
nmap -Pn -p- -sS -sV -oN $OUTPUT_DIR/port_scan.txt -iL $OUTPUT_DIR/active_ips.txt

# 3. Vulnerability Scanning
echo "[+] Running vulnerability scan with Nmap scripts..." | tee -a $LOG_FILE
nmap -Pn -sV --script=vuln -iL $OUTPUT_DIR/active_ips.txt -oN $OUTPUT_DIR/vuln_scan.txt

# 4. Web Server Scanning (Nikto)
echo "[+] Running Nikto scan on active web servers..." | tee -a $LOG_FILE
for ip in $(cat $OUTPUT_DIR/active_ips.txt); do
  nikto -host $ip -output $OUTPUT_DIR/nikto_$ip.txt
done

# 5. SSL Security Scan (TestSSL.sh)
echo "[+] Checking SSL/TLS configurations..." | tee -a $LOG_FILE
for ip in $(cat $OUTPUT_DIR/active_ips.txt); do
  testssl.sh $ip | tee $OUTPUT_DIR/ssl_scan_$ip.txt
done

# 6. SMB Vulnerability Scan
echo "[+] Scanning SMB vulnerabilities..." | tee -a $LOG_FILE
nmap -Pn -p 445 --script=smb-vuln* -iL $OUTPUT_DIR/active_ips.txt -oN $OUTPUT_DIR/smb_scan.txt

# 7. SSH Security Check
echo "[+] Checking SSH security settings..." | tee -a $LOG_FILE
nmap -Pn -p 22 --script=ssh2-enum-algos,ssh-hostkey -iL $OUTPUT_DIR/active_ips.txt -oN $OUTPUT_DIR/ssh_scan.txt

# 8. DNS Enumeration
echo "[+] Running DNS enumeration..." | tee -a $LOG_FILE
dnsenum --dnsserver 8.8.8.8 -f subdomains.txt -o $OUTPUT_DIR/dns_scan.txt

# 9. Summary
echo "[+] Scan completed. Results saved in $OUTPUT_DIR" | tee -a $LOG_FILE
