#!/bin/bash

validate_log_format() {
    local log_file="$1"
    local pattern="$2"
    local description="$3"
    
    if tail -n 10 "$log_file" 2>/dev/null | grep -q "$pattern"; then
        log_info "Log format valid: $description"
        return 0
    else
        log_error "Log format invalid: $description - pattern '$pattern' not found in $log_file"
        return 1
    fi
}

check_log_ingestion() {
    local test_message="$1"
    local service_name="$2"
    
    log_info "Testing $service_name log ingestion..."
    
    # Send test message to syslog
    logger -t "wazuh-test" "$test_message"
    
    # Check if it appears in Wazuh archives
    if timeout 10 grep -q "$test_message" /var/ossec/logs/archives/archives.log 2>/dev/null; then
        log_success "Log ingestion working for $service_name"
        return 0
    else
        log_error "Log ingestion failed for $service_name"
        return 1
    fi
}

verify_decoder_match() {
    local log_line="$1"
    local decoder_name="$2"
    
    log_info "Testing decoder: $decoder_name"
    
    # Use wazuh-logtest to verify decoder matches
    if echo "$log_line" | /var/ossec/bin/wazuh-logtest - 2>/dev/null | grep -q "$decoder_name"; then
        log_success "Decoder matched: $decoder_name"
        return 0
    else
        log_error "Decoder failed: $decoder_name"
        return 1
    fi
}
