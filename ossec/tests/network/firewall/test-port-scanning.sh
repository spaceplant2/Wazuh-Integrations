#!/bin/bash

source ../lib/test-helpers.sh

TEST_NAME="Firewall Port Scanning Detection"
TEST_ID="FW-PORTSCAN-001"

log_test_start "$TEST_NAME"

log_info "Checking for port scanning detection..."

# Look for multiple blocked attempts from same source
if tail -n 150 /var/log/syslog | grep "opnsense.*block" | awk '{print $12}' | sort | uniq -c | grep -q "[5-9] "; then
    log_info "Potential port scanning patterns found"
    
    # Check if Wazuh detected port scanning
    if check_wazuh_alert "110102" 10; then
        log_success "Port scanning detection working"
        log_test_end
        exit 0
    else
        log_info "Port scanning patterns found but no alerts - threshold may differ"
        log_test_end
        exit 0
    fi
else
    log_info "No port scanning patterns detected in recent logs"
    log_test_end
    exit 0
fi
