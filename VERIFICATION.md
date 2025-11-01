# Installation Verification Checklist

## Pre-Verification Steps
- [ ] Wazuh manager is running (`systemctl status wazuh-manager`)
- [ ] Wazuh agent is running (`systemctl status wazuh-agent`)
- [ ] Required services are running:
  - [ ] Bind9 (`systemctl status named`)
  - [ ] ISC-Kea (`systemctl status kea-dhcp4`)
  - [ ] OPNsense (check web interface)
  - [ ] ISC-Stork (`systemctl status isc-stork-server`)

## Rule Installation Verification
- [ ] Custom rules present in `/var/ossec/etc/rules/`
- [ ] Custom decoders present in `/var/ossec/etc/decoders/`
- [ ] File permissions correct (owned by root:wazuh)

## Functional Testing
Run each test script and verify success:
```bash
cd /var/ossec/tests/network/
# DNS Tests
./dns/test-dga-detection.sh
./dns/test-zone-transfer.sh

# DHCP Tests
./dhcp/test-starvation.sh
./dhcp/test-rogue-server.sh

# Additional component tests...
```

## Alert Verification
- [ ] Alerts appearing in Wazuh manager logs (`/var/ossec/logs/alerts/alerts.log`)
- [ ] Correct rule IDs triggering
- [ ] Alert details contain expected fields