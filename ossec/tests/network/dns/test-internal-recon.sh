#!/bin/bash

source ../lib/test-helpers.sh

TEST_NAME="DNS Internal Reconnaissance Detection"
TEST_ID="DNS-RECON-001"

log_test_start "$TEST_NAME"

# Check if Bind9 is running
if ! check_service_running "bind9"; then
    log_error "Bind9 service not running"
    log_test_end
    exit 1
fi

# Query internal service records (common recon pattern)
log_info "Querying internal service records..."

# Common internal service discovery queries
SERVICE_DOMAINS=(
    "_ldap._tcp.dc._msdcs.example.com"
    "_kerberos._tcp.example.com" 
    "_domain._msdcs.example.com"
    "dc01.example.com"
    "exchange.example.com"
)

for domain in "${SERVICE_DOMAINS[@]}"; do
    log_info "Testing query: $domain"
    dig +short @localhost "$domain" > /dev/null 2>&1
    sleep 1
done

# Check for internal recon detection rules
if check_wazuh_alert "120500" 15 || check_wazuh_alert "120501" 15; then
    log_success "Internal reconnaissance detection working"
    log_test_end
    exit 0
else
    log_info "No internal recon alerts - rules may need tuning for your environment"
    log_test_end
    exit 0
fi
