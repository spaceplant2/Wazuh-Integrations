# How to Debug Wazuh Decoders

## Testing Tool
```bash
/var/ossec/bin/wazuh-logtest
```

## Common Issues
- **No decoder match**: Regex pattern incorrect
- **Wrong fields**: Extract clauses not working
- **Partial match**: Regex needs adjustment

## Debug Process
1. Run `wazuh-logtest`
2. Paste raw log sample
3. Check if decoder name appears
4. Verify extracted fields match expected values

## Expected Output
```
**Phase 1: Completed decoding.
Decoder: 'your-decoder-name'
```
