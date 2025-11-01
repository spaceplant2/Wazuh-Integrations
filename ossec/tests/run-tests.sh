# /home/edothas/gitProjects/public/Wazuh-Integrations/ossec/tests/run-tests.sh
#!/bin/bash
set -e

# Initialize variables
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to run tests in a directory
run_tests() {
    local test_dir="$1"
    for test in "$test_dir"/test-*.sh; do
        if [ -x "$test" ]; then
            echo "Running test: $(basename "$test")"
            TOTAL_TESTS=$((TOTAL_TESTS + 1))
            if "$test"; then
                PASSED_TESTS=$((PASSED_TESTS + 1))
            else
                FAILED_TESTS=$((FAILED_TESTS + 1))
                echo "Test failed: $(basename "$test")"
            fi
        fi
    done
}

# Run all component tests
for component in network/*; do
    if [ -d "$component" ]; then
        echo "Testing component: $(basename "$component")"
        run_tests "$component"
    fi
done

# Print summary
echo "Test Summary:"
echo "Total: $TOTAL_TESTS"
echo "Passed: $PASSED_TESTS"
echo "Failed: $FAILED_TESTS"

# Exit with failure if any tests failed
[ "$FAILED_TESTS" -eq 0 ]