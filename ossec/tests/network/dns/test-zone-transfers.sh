#!/bin/bash

source $(dirname "$0")/../lib/test-helpers.sh

TEST_NAME="Zone Transfer Attempt Detection"
TEST_ID="DNS-ZONE-001"

log_test_start "$TEST_NAME"

# Attempt zone transfer (should be blocked and logged)
log_info "Attempting zone transfer for example.com"
dig @localhost example.com AXFR > /dev/null 2>&1

# Check for rule 100300 (zone transfer attempt)
if check_wazuh_alert "100300" 10; then
    log_success "Zone transfer attempt detection working correctly"
    log_test_end
    exit 0
else
    log_error "Zone transfer attempt detection failed"
    log_test_end
    exit 1
fi
