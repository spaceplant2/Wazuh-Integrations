#!/bin/bash

source $(dirname "$0")/../lib/test-helpers.sh

TEST_NAME="Firewall Internal Reconnaissance Detection"
TEST_ID="FW-RECON-001"

log_test_start "$TEST_NAME"

log_info "Checking for internal reconnaissance patterns..."

# Look for recent internal port scan patterns in firewall logs
if tail -n 100 /var/log/syslog | grep -q "opnsense.*block.*192.168.*445\|opnsense.*block.*192.168.*135\|opnsense.*block.*192.168.*139"; then
    log_info "Internal reconnaissance patterns found in firewall logs"
    
    # Check if Wazuh detected them
    if check_wazuh_alert "110400" 10; then
        log_success "Internal reconnaissance detection working"
        log_test_end
        exit 0
    else
        log_error "Firewall blocks found but no reconnaissance alerts"
        log_test_end
        exit 1
    fi
else
    log_info "No internal reconnaissance patterns in recent logs"
    log_test_end
    exit 0
fi
