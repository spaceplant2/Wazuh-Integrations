#!/bin/bash

source $(dirname "$0")/../lib/test-helpers.sh
source $(dirname "$0")/../lib/wazuh-api.sh

TEST_NAME="Kea Control Agent Security"
TEST_ID="DHCP-CTRL-001"

log_test_start "$TEST_NAME"

# Check if Kea Control Agent is running
if ! check_service_running "kea-ctrl-agent"; then
    log_info "Kea Control Agent not running - this may be normal"
    log_test_end
    exit 0
fi

log_info "Checking Kea Control Agent configuration..."

# Verify Control Agent is logging
if tail -n 30 /var/log/syslog | grep -q "kea-ctrl-agent"; then
    log_info "Kea Control Agent logging detected"
    
    # Check for Control Agent security rules
    if check_rule_active "131100" || check_rule_active "131103"; then
        log_success "Kea Control Agent monitoring configured"
        log_test_end
        exit 0
    else
        log_error "Kea Control Agent security rules not active"
        log_test_end
        exit 1
    fi
else
    log_info "No recent Control Agent logs found"
    log_test_end
    exit 0
fi
