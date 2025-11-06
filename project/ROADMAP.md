# Wazuh Network Infrastructure Monitoring - Implementation Status

## Completed ✅

### OPNsense Firewalls ✅
**Components:** Suricata, Firewall, DHCP, System Logs
**Security Coverage:**
- Real-time IPS alert correlation
- Firewall block/allow decision tracking
- Network traffic pattern analysis
- System-level security events

### Bind9 DNS Servers   ✅
**Components:** Authoritative DNS, Forwarding, Query Logging
**Security Coverage:**
- DNS tunneling detection (long domains, encoded data)
- DGA domain pattern recognition
- Zone transfer attempt monitoring
- Internal reconnaissance detection
- Query type anomaly detection

### ISC-Kea DHCP Servers ✅
**Components:** DHCPv4, DHCPv6, Control Agent, DDNS
**Security Coverage:**
- Rogue DHCP server detection
- DHCP starvation attack prevention
- Suspicious lease pattern identification
- IPv6 address manipulation detection
- Control API security monitoring

### ISC-Stork Management ✅
**Components:** Web UI, API, Service Monitoring
**Security Coverage:**
- Configuration change tracking
- Authentication security monitoring
- Service health correlation
- HA failover event tracking
- Administrative access auditing

### Pi-hole DNS Filtering ✅
**Components:** DNS Forwarding, Ad Blocking, Query Logging
**Security Coverage:**
- Blocked domain request monitoring
- Query pattern analysis
- Security event correlation with upstream DNS

## Stock Rule Integration
**Objective**: Leverage Wazuh's existing rules to reduce duplication and improve detection coverage

### Renumber Existing Rules

*Proposed Rule Numbering Scheme*

---

## Proposed Rule Numbering Scheme

### 100000-100999: DNS Monitoring
- 100000-100009: Base templates
- 100010-100019: **Stock DNS rule grouping**
- 100020-100029: **Stock security rule grouping** 
- 100100-100199: Pi-hole queries
- 100200-100299: Pi-hole domain analysis
- 100300-100399: DNS tunneling detection  
- 100400-100499: DGA domain detection
- 100500-100599: DNS correlation rules

### 101000-101999: DHCP Monitoring
- 101000-101009: Base templates
- 101010-101019: **Stock DHCP rule grouping**
- 101100-101199: DHCP server events
- 101200-101299: Suspicious DHCP clients
- 101300-101399: DHCP lease monitoring
- 101400-101499: DHCP correlation rules

### 102000-102999: OPNSense Integration
- 102000-102009: Base templates  
- 102010-102019: **Stock firewall rule grouping**
- 102020-102029: **Stock IDS rule grouping**
- 102100-102199: Firewall blocks
- 102200-102299: Suricata base
- 102300-102399: Suricata alerts
- 102400-102499: Firewall-Suricata correlation

### Parent Rule Strategy
- Create level 0 grouping rules for each integration point
- Ensure consistent field naming across stock/custom rules
- Maintain separate SID ranges while sharing logic

### DNS Rules Integration
- Identify relevant stock DNS rules (03100-03199 range)
- Create grouping rules for DNS query patterns
- Build correlation rules linking DNS events to Pi-hole/BIND9 alerts
- Maintain field consistency between stock and custom rules

### Network Rules Integration  
- Map stock firewall rules to OPNSense events
- Correlate Suricata alerts with network blocks
- Use existing Wazuh field extractions where possible

**Success Metrics**:
- 30% reduction in custom rule count
- Maintain or improve alert accuracy
- No degradation in detection coverage

## Ready for Testing 🔬

### Test Framework Development
**Priority:** HIGH - Required before new implementations
**Components to Validate:**
- DNS security rule effectiveness
- DHCP attack detection accuracy
- Firewall correlation logic
- Cross-service alerting
- False positive baseline

## Next Implementation Phase 🟡

### RADIUS Authentication
**Target Services:** FreeRADIUS, Windows NPS
**Security Objectives:**
- WiFi/VPN authentication monitoring
- Brute force attack detection
- EAP-TLS certificate validation
- Policy violation alerting
- Authentication chain completeness

### VPN Concentrators  
**Target Services:** OpenVPN, WireGuard, IPSec
**Security Objectives:**
- Remote access connection tracking
- Authentication failure monitoring
- Geographic access pattern analysis
- Traffic anomaly detection
- Session security validation

### Network Switches
**Target Services:** SNMP/Syslog from switching infrastructure
**Security Objectives:**
- Port security violation detection
- MAC address table monitoring
- STP topology change tracking
- Unauthorized device connection alerts
- VLAN security event correlation

## Future Implementation Phases 🔵

### Wireless Controllers
**Target:** UniFi, Aruba, Cisco WLC
**Focus:** Rogue AP detection, client association security, channel monitoring

### Load Balancers
**Target:** HAProxy, nginx, F5  
**Focus:** DDoS pattern recognition, backend health security, SSL monitoring

### Time Services
**Target:** NTP, Chrony
**Focus:** Time drift detection, stratum monitoring, time-based attacks

### Mail Servers
**Target:** Postfix, Exchange
**Focus:** SMTP security, spam pattern detection, exfiltration monitoring

### Web Proxies
**Target:** Squid, forward proxies
**Focus:** Content policy enforcement, URL filtering, authentication bypass

## Testing Integration

### Current Status
- All implemented components require test case development
- Test framework design in progress
- Validation procedures needed for each security control

### Going Forward
- New implementations include test development
- Automated validation for all components
- Continuous testing integrated into deployment process

## Success Metrics

### Operational Metrics
- All implemented components actively monitoring
- Security rules firing correctly
- Correlation working across services
- Acceptable false positive rate

### Coverage Gaps
- Network access layer (RADIUS/VPN) not yet monitored
- Physical network (switches) visibility missing
- Wireless security not implemented
- Application services pending

---
*Status: Operational foundations complete, testing phase initiated*
*Next: Deploy test framework, then RADIUS monitoring with integrated testing*