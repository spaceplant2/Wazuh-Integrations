# Contributing to Wazuh Network Security Integrations

## Adding New Rulesets

### Directory Structure
Place new components in the following structure:
```
ossec/
├── decoders/
│   └── your_service_decoders.xml
├── rules/
│   └── your_service_rules.xml
└── tests/
    └── network/
        └── your_service/
            ├── test-alert1.sh
            └── test-alert2.sh
```

### Rules and Decoders
1. Follow Wazuh XML format for rules and decoders
2. Use rule IDs in the assigned range (100000-199999)
3. Include clear descriptions and comments
4. Reference parent rules where appropriate

### Testing
1. Create a test directory for your service
2. Add bash test scripts that:
   - Generate relevant log entries
   - Verify correct alert generation
   - Use the common test helper functions
3. Follow the existing test naming convention: `test-feature.sh`

### Example Test Script
```bash
#!/bin/bash
source ../lib/test-helpers.sh

TEST_NAME="Your Test Description"
TEST_ID="SERVICE-001"

log_test_start "$TEST_NAME"

# Generate test condition
your_test_command

# Check for your rule
if check_wazuh_alert "your_rule_id" 10; then
    log_success "Test passed"
    log_test_end
    exit 0
else
    log_error "Test failed"
    log_test_end
    exit 1
fi
```

### Pull Request Process
1. Create branch with format: `ruleset/service-name`
2. Include only ruleset-related changes
3. Ensure all tests pass
4. Provide sample logs that trigger the rules

## Questions?
Open an issue for questions about adding new rulesets.