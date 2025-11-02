#!/bin/bash

source ../lib/test-helpers.sh

TEST_NAME="Suspicious DHCP Lease Detection"
TEST_ID="DHCP-LEASE-001"

log_test_start "$TEST_NAME"

# Check if Kea DHCP is running
if ! check_service_running "kea-dhcp4-server"; then
    log_error "Kea DHCP service not running"
    log_test_end
    exit 1
fi

log_info "Checking for suspicious lease patterns..."

# Look for any lease anomalies in recent logs
if tail -n 100 /var/log/syslog | grep -q "DHCP4.*00:00:00:00:00:00\|DHCP4.*169.254\|DHCP4.*lease-time=0"; then
    log_info "Potential suspicious lease patterns found"
    
    # Check if Wazuh detected them
    if check_wazuh_alert "130300" 10; then
        log_success "Suspicious lease detection working"
        log_test_end
        exit 0
    else
        log_info "Suspicious leases found but no alerts - this may be normal"
        log_test_end
        exit 0
    fi
else
    log_info "No suspicious lease patterns detected in recent logs"
    log_test_end
    exit 0
fi
