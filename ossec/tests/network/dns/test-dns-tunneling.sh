#!/bin/bash
# /var/ossec/tests/network/dns/test-dns-tunneling.sh

source ../lib/test-helpers.sh

TEST_NAME="DNS Tunneling Detection"
TEST_ID="DNS-TUNNEL-001"

log_test_start "$TEST_NAME"

# Generate DNS tunneling-like query (very long subdomain)
LONG_DOMAIN=$(head -c 80 /dev/urandom | base64 | tr -d '\n' | tr '+/' 'ab').test.example.com

log_info "Sending long domain query: $LONG_DOMAIN"
dig +short @localhost "$LONG_DOMAIN" > /dev/null 2>&1

# Check for rule 100100 (DNS tunneling detection)
if check_wazuh_alert "100100" 10; then
    log_success "DNS tunneling detection working correctly"
    log_test_end
    exit 0
else
    log_error "DNS tunneling detection failed"
    log_test_end
    exit 1
fi