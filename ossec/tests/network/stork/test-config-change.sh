#!/bin/bash

source ../../lib/test-helpers.sh

TEST_NAME="Stork Configuration Change Detection"
TEST_ID="STORK-001"

log_test_start "$TEST_NAME"

# Simulate configuration change
echo "user@example.com changed settings for server1" > /var/log/stork/audit.log

# Check for rule 100400 (Stork configuration change)
if check_wazuh_alert "100400" 10; then
    log_success "Configuration change detection working correctly"
    log_test_end
    exit 0
else
    log_error "Configuration change detection failed"
    log_test_end
    exit 1
fi