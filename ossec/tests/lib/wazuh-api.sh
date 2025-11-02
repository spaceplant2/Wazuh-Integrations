#!/bin/bash

WAZUH_API_URL="https://localhost:55000"
WAZUH_USER="${WAZUH_API_USER:-wazuh}"
WAZUH_PASSWORD="${WAZUH_API_PASSWORD:-wazuh}"

get_auth_token() {
    local response=$(curl -s -k -X POST \
        -H "Content-Type: application/json" \
        -d "{\"user\":\"$WAZUH_USER\",\"password\":\"$WAZUH_PASSWORD\"}" \
        "$WAZUH_API_URL/security/user/authenticate")
    
    echo "$response" | grep -o '"token":"[^"]*' | cut -d'"' -f4
}

check_rule_active() {
    local rule_id="$1"
    local token=$(get_auth_token)
    
    if [ -z "$token" ]; then
        log_error "Failed to get Wazuh API token"
        return 1
    fi
    
    local response=$(curl -s -k -X GET \
        -H "Authorization: Bearer $token" \
        "$WAZUH_API_URL/rules?rule_ids=$rule_id")
    
    if echo "$response" | grep -q "\"id\":\"$rule_id\""; then
        log_success "Rule $rule_id is active in Wazuh"
        return 0
    else
        log_error "Rule $rule_id not found or inactive"
        return 1
    fi
}

get_recent_alerts() {
    local rule_id="$1"
    local token=$(get_auth_token)
    local minutes="${2:-5}"
    
    if [ -z "$token" ]; then
        log_error "Failed to get Wazuh API token"
        return 1
    fi
    
    local timestamp=$(date -d "$minutes minutes ago" +%s)
    
    curl -s -k -X GET \
        -H "Authorization: Bearer $token" \
        "$WAZUH_API_URL/rootcheck?rule_ids=$rule_id&timestamp=$timestamp"
}
