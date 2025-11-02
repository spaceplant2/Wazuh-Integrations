#!/bin/bash

echo "=== Wazuh Network Monitoring Full Test Suite ==="
echo "Start Time: $(date)"
echo
echo "Wazuh Directory: /var/ossec"
echo "================================================"
echo

# Source our helpers
source lib/test-helpers.sh

# Check if Wazuh is running
if ! check_service_running "wazuh-manager"; then
    log_error "Wazuh manager is not running!"
    exit 1
fi

# Run DNS tests
echo "--- DNS Security Tests ---"
if [ -f "network/dns/test-dns-tunneling.sh" ]; then
    ./network/dns/test-dns-tunneling.sh
else
    log_error "DNS tunneling test not found"
fi

if [ -f "network/dns/test-dga-detection.sh" ]; then
    ./network/dns/test-dga-detection.sh
else
    log_error "DGA detection test not found"
fi

# Run DHCP tests
echo "--- DHCP Security Tests ---"
if [ -f "network/dhcp/test-rogue-dhcp.sh" ]; then
    ./network/dhcp/test-rogue-dhcp.sh
else
    log_error "Rogue DHCP test not found"
fi

echo
echo "=== Test Suite Complete ==="
echo "End Time: $(date)"

# Summary
echo
echo "=== Summary ==="
echo "Check individual test results above."
echo "View detailed alerts in: /var/ossec/logs/alerts/alerts.log"
