# Wazuh Network Security Integrations

Comprehensive security monitoring for critical network infrastructure components using Wazuh.

## Components Monitored
- DNS (Bind9)
- DHCP (ISC-Kea)
- Firewalls (OPNsense)
- Management Systems (ISC-Stork)

## Prerequisites
- Wazuh manager (4.x) with working installation
- Root/sudo access on Wazuh manager
- Network services configured and running:
  - Bind9 DNS server
  - ISC-Kea DHCP server
  - OPNsense firewall
  - ISC-Stork management system

## Quick Start
1. Clone repository:
```bash
git clone https://github.com/spaceplant2/Wazuh-Integrations.git
```

2. Install custom rules and decoders:
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
├── install.sh       # Installation script
├── ossec/
│   ├── decoders/   # Custom log decoders
│   ├── rules/      # Alert rules
│   └── tests/      # Validation tests
└── docs/           # Additional documentation
```

## Testing
Each security component has dedicated test scripts that verify rule functionality:
- DNS security tests (`ossec/tests/network/dns/`)
- DHCP monitoring tests (`ossec/tests/network/dhcp/`)
- Firewall alert tests (`ossec/tests/network/firewall/`)
- Management system tests (`ossec/tests/network/stork/`)

For detailed testing instructions, see [Testing Guide](TESTING.md).

## Troubleshooting
See [Troubleshooting Guide](TROUBLESHOOTING.md) for common issues and solutions.

## License
MIT License - see [LICENSE](LICENSE) file.