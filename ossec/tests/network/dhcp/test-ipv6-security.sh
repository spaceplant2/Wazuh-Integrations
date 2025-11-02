#!/bin/bash

source ../lib/test-helpers.sh

TEST_NAME="DHCPv6 Security Monitoring"
TEST_ID="DHCP-IPV6-001"

log_test_start "$TEST_NAME"

# Check if Kea DHCPv6 is running
if ! check_service_running "kea-dhcp6-server"; then
    log_info "Kea DHCPv6 not running - this may be normal"
    log_test_end
    exit 0
fi

log_info "Checking DHCPv6 monitoring configuration..."

# Look for DHCPv6 activity in logs
if tail -n 50 /var/log/syslog | grep -q "DHCP6_"; then
    log_info "DHCPv6 activity 
    detected in logs"
    
    # Check if Wazuh is processing DHCPv6 events
    if tail -n 20 /var/ossec/logs/alerts/alerts.log | grep -q "130400\|130401"; then
        log_success "DHCPv6 security monitoring working"
        log_test_end
        exit 0
    else
        log_error "Wazuh not processing DHCPv6 security events"
        log_test_end
        exit 1
    fi
else
    log_info "No recent DHCPv6 activity found"
    log_test_end
    exit 0
fi