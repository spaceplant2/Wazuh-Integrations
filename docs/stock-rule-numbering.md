## Wazuh Rule Categories & Ranges

## Wazuh Internal Rule Ranges (1-9999)

### Core System
- 00100-00199: Wazuh manager
- 00200-00299: Wazuh agent  
- 00300-00399: Wazuh cluster
- 00400-00499: Wazuh API

### Log Analysis
- 00500-00599: Syslog
- 00600-00699: JSON parsing
- 00700-00799: XML parsing
- 00800-00899: CSV parsing

### Network Protocols  
- 03100-03199: DNS
- 03200-03299: DHCP
- 03300-03399: HTTP
- 03400-03499: FTP
- 03500-03599: SSH
- 03600-03699: SSL/TLS

### Security Events
- 05000-05099: SSH authentication
- 05100-05199: Failed logins
- 05200-05299: Brute force attacks
- 05300-05399: Port scanning
- 05400-05499: Malware detection

### System Monitoring
- 05500-05599: File integrity
- 05600-05699: Rootkit detection  
- 05700-05799: Process monitoring
- 05800-05899: Registry changes
- 05900-05999: System calls

### 6000-6999: System Calls & Processes
- 6000-6099: Process execution
- 6100-6199: System calls  
- 6200-6299: Kernel events
- 6300-6399: Service management

### 7000-7999: Configuration Audit
- 7000-7099: System configuration
- 7100-7199: User management
- 7200-7299: File permissions
- 7300-7399: Policy violations

### 8000-8999: Policy Monitoring  
- 8000-8099: Security policy
- 8100-8199: Compliance checks
- 8200-8299: Audit rules

### 9000-9999: Application Logs
- 9000-9099: Web servers
- 9100-9199: Database servers
- 9200-9299: Mail servers

## Security Events (10000-19999)

### Security Events (10000-19999)
- 10000-10999: Authentication
- 11000-11999: System events
- 12000-12999: Firewall
- 13000-13999: Network
- 14000-14999: Intrusion detection
- 15000-15999: Web applications

## OS-Specific (20000-49999)

### 20000-29999: Windows Specific
- 20000-20999: Windows security
- 21000-21999: Windows application
- 22000-22999: Active Directory

### 30000-39999: Linux Specific  
- 30000-30999: Linux security
- 31000-31999: Linux application
- 32000-32999: Package management

### 40000-49999: Other OS & Network
- 40000-40999: macOS
- 41000-41999: Network devices
- 42000-42999: Cloud infrastructure

### Security Events
- 50000-50999: Authentication
- 51000-51999: System events  
- 52000-52999: Firewall
- 53000-53999: Network
- 54000-54999: Intrusion detection
- 55000-55999: Malware
- 56000-56999: Web applications

### Operating Systems
- 57000-57999: Windows
- 58000-58999: Linux
- 59000-59999: macOS
- 60000-60999: Solaris
- 61000-61999: AIX
- 62000-62999: HP-UX

### Applications
- 63000-63999: Databases
- 64000-64999: Web servers
- 65000-65999: Mail servers
- 66000-66999: DNS servers

### Cloud & Containers
- 67000-67999: AWS
- 68000-68999: Azure  
- 69000-69999: GCP
- 70000-70999: Docker
- 71000-71999: Kubernetes

### Compliance
- 72000-72999: PCI DSS
- 73000-73999: GDPR
- 74000-74999: HIPAA
- 75000-75999: NIST
- 76000-76999: TSC
