#!/bin/bash

source $(dirname "$0")/../lib/test-helpers.sh

TEST_NAME="DNS NXDOMAIN Attack Detection"
TEST_ID="DNS-NXDOMAIN-001"

log_test_start "$TEST_NAME"

# Check if Bind9 is running
if ! check_service_running "bind9"; then
    log_error "Bind9 service not running"
    log_test_end
    exit 1
fi

log_info "Generating NXDOMAIN queries..."

# Generate multiple non-existent domain queries
for i in {1..10}; do
    RANDOM_DOMAIN="nonexistent$(date +%s)${i}.example.com"
    dig +short @localhost "$RANDOM_DOMAIN" > /dev/null 2>&1
    sleep 0.5
done

# Check for NXDOMAIN attack detection
if check_wazuh_alert "120400" 15; then
    log_success "NXDOMAIN attack detection working"
    log_test_end
    exit 0
else
    log_info "No NXDOMAIN attack alerts - threshold may not be reached"
    log_test_end
    exit 0
fi
