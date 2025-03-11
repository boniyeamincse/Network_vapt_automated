# Network Security VAPT Script

## 📌 Overview
This **Network Security VAPT (Vulnerability Assessment & Penetration Testing) Script** automates the scanning of network services, detecting vulnerabilities, and providing security insights for **Akij Group** or any internal network.

## 🚀 Features
- **Live Host Discovery**: Identifies active devices on the network.
- **Port Scanning**: Detects open ports and running services.
- **Vulnerability Scanning**: Uses Nmap scripts to find security flaws.
- **Web Security Scanning**: Identifies web server vulnerabilities with Nikto.
- **SSL/TLS Security Testing**: Checks for outdated protocols and weak encryption.
- **SMB and SSH Security**: Scans for misconfigured SMB (port 445) and SSH (port 22).
- **DNS Enumeration**: Identifies subdomains and zone transfer issues.
- **Logging & Reporting**: Saves scan results in an organized directory.

## 🛠️ Installation & Usage
### 1️⃣ Install Dependencies
Ensure you have the following tools installed:
```bash
sudo apt update && sudo apt install -y nmap nikto dnsenum testssl.sh
```

### 2️⃣ Clone the Repository
```bash
git clone https://github.com/yourusername/Network-VAPT-Script.git
cd Network-VAPT-Script
```

### 3️⃣ Run the Script
```bash
chmod +x vapt_scan.sh
./vapt_scan.sh
```

## 📂 Output Directory Structure
```
📁 vapt_results/
 ├── active_ips.txt
 ├── port_scan.txt
 ├── vuln_scan.txt
 ├── nikto_results.txt
 ├── ssl_scan_results.txt
 ├── smb_scan.txt
 ├── ssh_scan.txt
 ├── dns_scan.txt
 ├── vapt_scan_YYYY-MM-DD_HH-MM-SS.log
```

## 🔥 To-Do / Future Features
- 🔹 **Brute Force Testing** (Hydra, Medusa)
- 🔹 **Automated Report Generation** (CSV/PDF Output)
- 🔹 **Email Alerts for Critical Issues**

## 📜 License
This project is **open-source** under the MIT License.

## 📧 Contact
For any queries, reach out to **[Your Name]** at [Your Email] or connect on **[LinkedIn]**.

Happy Hacking! 🚀

