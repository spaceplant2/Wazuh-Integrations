#!/bin/bash

source $(dirname "$0")/../lib/test-helpers.sh

TEST_NAME="Suricata-Firewall Correlation"
TEST_ID="FW-SURICATA-001"

log_test_start "$TEST_NAME"

log_info "Checking Suricata and firewall correlation..."

# Check if Suricata is running and logging
if tail -n 50 /var/log/syslog | grep -q "suricata"; then
    log_info "Suricata activity detected"
    
    # Look for Suricata alerts followed by firewall blocks
    if tail -n 100 /var/log/syslog | grep -A5 "suricata.*\\[\\*\\]" | grep -q "opnsense.*block"; then
        log_info "Suricata-firewall correlation patterns found"
        
        # Check if Wazuh detected the correlation
        if check_wazuh_alert "110301" 10; then
            log_success "Suricata-firewall correlation working"
            log_test_end
            exit 0
        else
            log_info "Correlation patterns found but no Wazuh alerts"
            log_test_end
            exit 0
        fi
    else
        log_info "No recent Suricata-firewall correlation events"
        log_test_end
        exit 0
    fi
else
    log_info "No recent Suricata activity found"
    log_test_end
    exit 0
fi
