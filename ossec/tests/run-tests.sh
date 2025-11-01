#!/bin/bash
set -e

# Source helper functions
source lib/test-helpers.sh

log_info "Starting Wazuh integration tests"

# Initialize counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to run tests in a directory
run_tests() {
    local test_dir="$1"
    for test in "$test_dir"/test-*.sh; do
        if [ -x "$test" ]; then
            TOTAL_TESTS=$((TOTAL_TESTS + 1))
            log_test_start "$(basename "$test")"
            
            if "$test"; then
                PASSED_TESTS=$((PASSED_TESTS + 1))
                log_success "Test passed: $(basename "$test")"
            else
                FAILED_TESTS=$((FAILED_TESTS + 1))
                log_error "Test failed: $(basename "$test")"
            fi
            log_test_end
        fi
    done
}

# Run all component tests
for component in network/*; do
    if [ -d "$component" ]; then
        log_info "Testing component: $(basename "$component")"
        run_tests "$component"
    fi
done

# Print summary
log_info "Test Summary:"
echo "Total: $TOTAL_TESTS"
echo "Passed: $PASSED_TESTS"
echo "Failed: $FAILED_TESTS"

# Exit with failure if any tests failed
[ "$FAILED_TESTS" -eq 0 ]