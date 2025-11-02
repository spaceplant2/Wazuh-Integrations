#!/bin/bash

source ../../lib/test-helpers.sh

TEST_NAME="Stork Service Status Change Detection"
TEST_ID="STORK-003"

log_test_start "$TEST_NAME"

# Simulate service status change
echo "Service kea-dhcp4@server1 changed state to 'stopped'" > /var/log/stork/service.log

# Check for rule 100402 (Stork service status change)
if check_wazuh_alert "100402" 10; then
    log_success "Service status change detection working correctly"
    log_test_end
    exit 0
else
    log_error "Service status change detection failed"
    log_test_end
    exit 1
fi