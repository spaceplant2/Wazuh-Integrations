#!/bin/bash
# /var/ossec/tests/network/management/test-stork-auth.sh

source ../lib/test-helpers.sh

TEST_NAME="Stork Authentication Monitoring"
TEST_ID="STORK-AUTH-001"

log_test_start "$TEST_NAME"

log_info "Checking Stork authentication logging"

# Verify Stork is logging authentication events
if tail -n 30 /var/log/syslog | grep -q "stork.*user.*log"; then
    log_info "Stork authentication events found in logs"
    
    # Check if Wazuh is processing Stork auth events
    if tail -n 20 "$ALERTS_LOG" | grep -q "132000\|132001\|132002"; then
        log_success "Stork authentication monitoring working"
        log_test_end
        exit 0
    else
        log_error "Wazuh not processing Stork authentication events"
        log_test_end
        exit 1
    fi
else
    log_info "No recent Stork auth events - check Stork logging configuration"
    log_test_end
    exit 0  # Informational, not a failure
fi
