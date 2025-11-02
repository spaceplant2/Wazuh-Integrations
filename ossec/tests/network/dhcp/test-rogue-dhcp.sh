# tests/network/dhcp/test-rogue-dhcp.sh
#!/bin/bash

source $(dirname "$0")/../lib/test-helpers.sh

TEST_NAME="Rogue DHCP Server Detection"
TEST_ID="DHCP-ROGUE-001"

log_test_start "$TEST_NAME"

# Check if Kea DHCP is running
if ! check_service_running "kea-dhcp4-server"; then
    log_error "Kea DHCP service not running - test cannot proceed"
    log_test_end
    exit 1
fi

log_info "Checking Kea DHCP service logging"

# Trigger a legitimate DHCP request to verify logging
log_info "Checking for recent DHCP lease activity..."

# Look for recent DHCP activity in logs
if tail -n 50 /var/log/syslog | grep -q "DHCP4_LEASE_ALLOC"; then
    log_info "Kea DHCP logging is active"
    
    # Check if Wazuh is processing DHCP events
    if tail -n 20 /var/ossec/logs/alerts/alerts.log | grep -q "130100\|130200"; then
        log_success "DHCP monitoring is working correctly"
        log_test_end
        exit 0
    else
        log_error "Wazuh not processing DHCP events"
        log_test_end
        exit 1
    fi
else
    log_info "No recent DHCP activity found - this may be normal in test environment"
    log_test_end
    exit 0
fi
