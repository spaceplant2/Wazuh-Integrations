# Testing Guide

## Prerequisites
- All components installed via `install.sh`
- Root/sudo access
- Network services running and accessible

## Running Tests
1. Navigate to test directory:
```bash
cd ossec/tests
```

2. Run all tests:
```bash
sudo ./run-tests.sh
```

3. Run specific component tests:
```bash
sudo ./network/dns/test-dga-detection.sh
sudo ./network/dhcp/test-starvation.sh
```

## Test Results
- Success: All tests pass with exit code 0
- Failure: Any test fails with exit code 1
- Results logged to console with timestamps

## Test Components
### DNS Tests
- DGA domain detection
- Zone transfer attempts
- Query failures

### DHCP Tests
- Starvation attacks
- Rogue server detection
- Lease exhaustion

### Firewall Tests
- Rule violations
- Configuration changes
- Access attempts

### Management Tests
- Configuration changes
- Access control
- Service status changes