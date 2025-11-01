# Wazuh Network Monitoring Test Suite

## Quick Start
```bash
cd /var/ossec/tests

# Run all tests
./run-all.sh

# Run specific component tests
./run-component.sh dns
./run-component.sh dhcp

# Run individual test
./network/dns/test-dns-tunneling.sh
