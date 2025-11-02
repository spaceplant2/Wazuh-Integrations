#!/bin/bash

COMPONENT="$1"

if [ -z "$COMPONENT" ]; then
    echo "Usage: $0 {dns|dhcp|firewall|all}"
    echo ""
    echo "Components:"
    echo "  dns      - DNS security tests"
    echo "  dhcp     - DHCP security tests" 
    echo "  firewall - Firewall correlation tests"
    echo "  all      - Run all tests"
    exit 1
fi

# Source helpers
source lib/test-helpers.sh

# Check Wazuh is running
if ! check_service_running "wazuh-manager"; then
    log_error "Wazuh manager is not running!"
    exit 1
fi

case "$COMPONENT" in
    "dns")
        echo "=== Running DNS Security Tests ==="
        ./network/dns/test-dns-tunneling.sh
        ./network/dns/test-dga-detection.sh
        ;;
    "dhcp")
        echo "=== Running DHCP Security Tests ==="
        ./network/dhcp/test-rogue-dhcp.sh
        ;;
    "firewall")
        echo "=== Running Firewall Tests ==="
        echo "Firewall tests require active traffic - run manually"
        ;;
    "all")
        ./run-all.sh
        ;;
    *)
        echo "Unknown component: $COMPONENT"
        echo "Use: dns, dhcp, firewall, or all"
        exit 1
        ;;
esac
