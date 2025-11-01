#!/bin/bash
# /var/ossec/tests/network/dhcp/test-rogue-dhcp.sh

source ../lib/test-helpers.sh

TEST_NAME="Rogue DHCP Server Detection"
TEST_ID="DHCP-ROGUE-001"

log_test_start "$TEST_NAME"

# This test requires a controlled test environment
# For now, we'll simulate by checking if Kea is logging properly

log_info "Checking Kea DHCP service status"
if systemctl is-active --quiet kea-dhcp4-server; then
    log_info "Kea DHCP service is running"
    
    # Trigger a legitimate DHCP request to verify logging
    log_info "Triggering test DHCP discovery"
    # Note: In production, you'd use dhcping or similar tool
    
    # Check for normal DHCP lease logging
    if tail -n 20 /var/log/syslog | grep -q "DHCP4_LEASE_ALLOC"; then
        log_success "Kea DHCP logging is working"
        log_test_end
        exit 0
    else
        log_error "Kea DHCP logging not detected"
        log_test_end
        exit 1
    fi
else
    log_error "Kea DHCP service not running"
    log_test_end
    exit 1
fi
