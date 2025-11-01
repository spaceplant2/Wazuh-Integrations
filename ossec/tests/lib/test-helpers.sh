#!/bin/bash
# /var/ossec/tests/lib/test-helpers.sh

WAZUH_DIR="/var/ossec"
ALERTS_LOG="$WAZUH_DIR/logs/alerts/alerts.log"
ARCHIVES_LOG="$WAZUH_DIR/logs/archives/archives.log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${YELLOW}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_test_start() {
    echo "=== TEST: $1 ==="
    echo "Start Time: $(date)"
}

log_test_end() {
    echo "End Time: $(date)"
    echo "=== TEST COMPLETE ==="
    echo
}

check_wazuh_alert() {
    local rule_id="$1"
    local timeout="$2"
    local search_pattern="$3"
    
    log_info "Checking for Wazuh alert (Rule: $rule_id, Timeout: ${timeout}s)"
    
    # Get current alert position
    local start_line=$(wc -l < "$ALERTS_LOG" 2>/dev/null || echo 0)
    
    # Wait for new alerts
    local end_time=$(( $(date +%s) + timeout ))
    
    while [ $(date +%s) -lt $end_time ]; do
        local current_line=$(wc -l < "$ALERTS_LOG" 2>/dev/null || echo 0)
        
        if [ "$current_line" -gt "$start_line" ]; then
            # Check for rule ID in new alerts
            if tail -n +$((start_line + 1)) "$ALERTS_LOG" | grep -q "Rule.id.*\"$rule_id\""; then
                log_success "Alert detected for rule $rule_id"
                return 0
            fi
        fi
        sleep 1
    done
    
    log_error "No alert detected for rule $rule_id within ${timeout}s"
    return 1
}

restart_wazuh_manager() {
    log_info "Restarting Wazuh manager to reload rules..."
    systemctl restart wazuh-manager
    sleep 10  # Wait for service to fully start
}

validate_decoders() {
    log_info "Validating Wazuh decoders..."
    $WAZUH_DIR/bin/wazuh-logtest -t
    return $?
}