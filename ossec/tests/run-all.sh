#!/bin/bash
# /var/ossec/tests/run-component.sh

COMPONENT="$1"

case "$COMPONENT" in
    "dns")
        echo "Running DNS Security Tests..."
        ./network/dns/test-dns-tunneling.sh
        ./network/dns/test-dga-detection.sh
        ./network/dns/test-zone-transfers.sh
        ;;
    "dhcp")
        echo "Running DHCP Security Tests..."
        ./network/dhcp/test-rogue-dhcp.sh
        ./network/dhcp/test-starvation-attack.sh
        ./network/dhcp/test-suspicious-leases.sh
        ;;
    "firewall")
        echo "Running Firewall Tests..."
        ./network/firewall/test-firewall-blocks.sh
        ./network/firewall/test-port-scanning.sh
        ;;
    "management")
        echo "Running Management Plane Tests..."
        ./network/management/test-stork-auth.sh
        ./network/management/test-stork-config.sh
        ;;
    *)
        echo "Usage: $0 {dns|dhcp|firewall|management}"
        exit 1
        ;;
esac
