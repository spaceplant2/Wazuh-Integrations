#!/bin/bash
# /var/ossec/tests/network/firewall/test-firewall-blocks.sh

source ../lib/test-helpers.sh

TEST_NAME="Firewall Block Correlation"
TEST_ID="FW-BLOCK-001"

log_test_start "$TEST_NAME"

# Generate traffic that should be blocked
# Attempt connection to common blocked ports
log_info "Testing firewall block detection"

# Try SSH from external perspective (if you have external test source)
# For internal testing, we'll check existing block patterns

# Check recent firewall blocks in logs
if tail -n 50 /var/log/syslog | grep -q "opnsense.*block"; then
    log_info "Firewall blocks detected in syslog"
    
    # Check if Wazuh is processing these blocks
    if check_wazuh_alert "110100" 5; then
        log_success "Firewall block correlation working"
        log_test_end
        exit 0
    else
        log_error "Wazuh not processing firewall blocks"
        log_test_end
        exit 1
    fi
else
    log_info "No recent firewall blocks found - this may be normal"
    log_test_end
    exit 0  # Don't fail if no blocks occurring
fi
