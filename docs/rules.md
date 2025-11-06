# How to Debug Wazuh Rules

## Testing Tool
```bash
/var/ossec/bin/wazuh-logtest
```

## Common Issues
- **Rule not triggering**: Level too high, conditions wrong
- **False positives**: Level too low, conditions too broad
- **Correlation failing**: if_matched_sid/same_field incorrect

## Debug Process
1. Run `wazuh-logtest`
2. Paste log that should trigger rule
3. Check if rule ID appears in output
4. Verify rule level and description match

## Testing Correlation Rules
- Test each source rule individually first
- Then test with multiple logs in sequence
- Check manager logs for context errors
