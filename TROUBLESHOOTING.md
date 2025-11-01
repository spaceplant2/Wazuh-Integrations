# Troubleshooting Guide

## Common Issues and Solutions

### No Alerts Generated
1. Check Wazuh services:
```bash
systemctl status wazuh-manager
systemctl status wazuh-agent
```

2. Verify log forwarding:
```bash
tail -f /var/ossec/logs/ossec.log
```

3. Test rule matching:
```bash
/var/ossec/bin/ossec-logtest
```

### Test Script Failures
1. Verify service connectivity:
```bash
# DNS
dig @localhost example.com
# DHCP
systemctl status kea-dhcp4
```

2. Check permissions:
```bash
ls -l /var/ossec/etc/rules/
ls -l /var/ossec/etc/decoders/
```

3. Review test logs:
```bash
tail -f /var/ossec/logs/ossec.log
```

### Alert Rules Not Working
1. Verify rule syntax:
```bash
/var/ossec/bin/verify-rules-config
```

2. Check rule loading:
```bash
grep -r "rule id" /var/ossec/logs/ossec.log
```

3. Test specific rules:
```bash
cd /var/ossec/tests/network/
./run-specific-test.sh <test-name>
```

## Getting Help
- Review logs in `/var/ossec/logs/`
- Check Wazuh documentation
- Submit issues on GitHub