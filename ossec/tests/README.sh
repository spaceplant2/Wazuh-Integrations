# tests/README.md
# Wazuh Network Monitoring Test Suite

## Overview
Automated tests for validating Wazuh network infrastructure monitoring rules and decoders.

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
