#!/bin/bash

source ../../lib/test-helpers.sh

TEST_NAME="Stork Authentication Failure Detection"
TEST_ID="STORK-002"

log_test_start "$TEST_NAME"

# Simulate failed login
echo "Failed login attempt from 192.168.1.100 for user admin" > /var/log/stork/auth.log

# Check for rule 100401 (Stork authentication failure)
if check_wazuh_alert "100401" 10; then
    log_success "Authentication failure detection working correctly"
    log_test_end
    exit 0
else
    log_error "Authentication failure detection failed"
    log_test_end
    exit 1
fi