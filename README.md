# Wazuh Network Security Integrations

Comprehensive security monitoring for critical network infrastructure components using Wazuh.

## Components Monitored
- DNS (Bind9)
- DHCP (ISC-Kea)
- Firewalls (OPNsense)
- Management Systems (ISC-Stork)

## Prerequisites
- Wazuh manager and agent installed
- Network services running (Bind9, Kea, OPNsense, Stork)
- Root/sudo access for installation
- Bash shell environment

## Quick Start
1. Clone the repository:
```bash
git clone https://github.com/yourusername/Wazuh-Integrations.git
```

2. Run installation script:
```bash
cd Wazuh-Integrations
sudo ./install.sh
```

3. Verify installation:
```bash
cd ossec/tests
sudo ./run-tests.sh
```

## Directory Structure
```
├── ansible/          # Deployment automation
├── ossec/
│   ├── decoders/    # Custom log decoders
│   ├── rules/       # Alert rules
│   └── tests/       # Validation tests
└── docs/            # Additional documentation
```

## Testing
Each component has dedicated test scripts that verify rule functionality:
- DNS security tests (`ossec/tests/network/dns/`)
- DHCP monitoring tests (`ossec/tests/network/dhcp/`)
- Firewall alert tests (`ossec/tests/network/firewall/`)
- Management system tests (`ossec/tests/network/stork/`)

## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License
This project is licensed under the MIT License - see [LICENSE](LICENSE) file.

