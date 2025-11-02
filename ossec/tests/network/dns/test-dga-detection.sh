# tests/network/dns/test-dga-detection.sh
#!/bin/bash

source ../lib/test-helpers.sh

TEST_NAME="DGA Domain Detection"
TEST_ID="DNS-DGA-001"

log_test_start "$TEST_NAME"

# Check if Bind9 is running
if ! check_service_running "bind9"; then
    log_error "Bind9 service not running - test cannot proceed"
    log_test_end
    exit 1
fi

# Generate DGA-like domain (random characters)
DGA_DOMAIN="xjfhwepqkjmntest.xyz"

log_info "Sending DGA-like domain query: $DGA_DOMAIN"
dig +short @localhost "$DGA_DOMAIN" > /dev/null 2>&1

# Check for rule 100200 (DGA detection)
if check_wazuh_alert "100200" 15; then
    log_success "DGA domain detection working correctly"
    log_test_end
    exit 0
else
    log_error "DGA domain detection failed"
    log_test_end
    exit 1
fi
