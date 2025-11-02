# Wazuh Network Infrastructure Monitoring Roadmap

## Executive Summary
This document outlines the implementation roadmap for comprehensive network infrastructure monitoring using Wazuh, covering DNS, DHCP, firewall, authentication, and network transport layers with full security correlation capabilities.

## Current Implementation Status ✅

### Core Infrastructure Monitoring

**OPNsense Firewalls** - Implemented
- Suricata IPS monitoring
- Firewall block/allow logs  
- DHCP service monitoring
- General syslog correlation

**Bind9 DNS Servers** - Implemented
- DNS query monitoring
- DGA (Domain Generation Algorithm) detection
- DNS tunneling detection
- Zone transfer security
- Reconnaissance detection

**ISC-Kea DHCP** - Implemented
- IPv4/IPv6 lease monitoring
- Rogue DHCP server detection
- DHCP starvation attacks
- HA failover monitoring
- Control Agent security

**ISC-Stork** - Implemented
- Management plane monitoring
- Configuration change tracking
- Service health monitoring
- Authentication security
- API access monitoring

**Pi-hole DNS** - Implemented
- DNS query filtering events
- Security event correlation
- Blocked domain monitoring

### Security Capabilities Achieved
- DNS tunneling & DGA detection
- Rogue DHCP server detection
- Network reconnaissance monitoring  
- Authentication chain correlation
- Cross-service attack detection
- HA/failover event tracking
- Configuration change monitoring
- API security monitoring

## Release Plan

### v0.1 - Initial Release ✅
**Status:** Complete
- Core DNS/DHCP/firewall monitoring implemented
- Test framework established
- Ansible deployment automation
- Basic documentation

### v0.2 - Real-World Testing & Validation 🟡
**Next Priority**
- Production environment testing
- Performance benchmarking and optimization
- Rule tuning based on real traffic patterns
- False positive analysis and reduction
- Documentation improvements from user feedback

### v0.3 - Rule ID Harmonization 🔵
**Future Release**
- Audit and resolve rule ID conflicts with official Wazuh rulesets
- Define and implement safe rule ID ranges
- Update all rule files and test scripts with new IDs
- Document new rule ID scheme

### v1.0 - Production Ready 🟢
**Target Release**
- All known issues resolved
- Extensive validation completed
- Performance optimized for production
- Comprehensive documentation
- Community feedback incorporated

## Phase 2: Network Access & Authentication 🟡

### Priority 1: RADIUS Monitoring
**Target:** FreeRADIUS, Windows NPS

**Security Focus:**
- WiFi/VPN authentication correlation
- EAP-TLS certificate monitoring
- Brute force detection
- Policy violation alerts
- Authentication chain completeness

### Priority 2: VPN Infrastructure
**Target:** OpenVPN, WireGuard, IPSec

**Security Focus:**
- Connection lifecycle monitoring
- Failed authentication tracking
- Traffic pattern anomalies
- Geographic access anomalies
- Remote access security

### Priority 3: Wireless Infrastructure
**Target:** UniFi, Aruba, Cisco WLC

**Security Focus:**
- Rogue AP detection
- Client association patterns
- Signal quality monitoring
- Channel change tracking
- Physical network access

## Phase 3: Network Transport & Availability 🔵

### Switch Monitoring
**Target:** SNMP/syslog from network switches

**Security Focus:**
- Port status & MAC address tracking
- STP topology changes
- Unauthorized device detection
- VLAN security events
- Network topology visibility

### Load Balancer Monitoring
**Target:** HAProxy, nginx, F5

**Security Focus:**
- Backend health monitoring
- DDoS detection patterns
- SSL certificate management
- Session persistence issues
- Service delivery integrity

### Time Service Monitoring
**Target:** NTP, Chrony

**Security Focus:**
- NTP stratum & peer monitoring
- Time drift detection
- Time-based attack indicators
- Service synchronization

## Phase 4: Application Services 🟣

### Mail Server Security
**Target:** Postfix, Exchange

**Security Focus:**
- SMTP authentication security
- Spam/malware pattern detection
- Data exfiltration attempts
- TLS negotiation issues

### Proxy Server Monitoring
**Target:** Squid, forward proxies

**Security Focus:**
- URL filtering violations
- Content policy enforcement
- Authentication bypass attempts
- Data exfiltration detection

## Technical Implementation Status

### Completed Components ✅

**Core Infrastructure**
- [x] OPNsense decoders & rules
- [x] Bind9 decoders & rules
- [x] ISC-Kea DHCP decoders & rules
- [x] ISC-Stork decoders & rules
- [x] Pi-hole integration patterns

**Security Framework**
- [x] Cross-service correlation rules
- [x] Syslog format compatibility
- [x] HA/failover monitoring
- [x] Configuration change tracking

**Testing Framework** 
- [x] Test case development for implemented components
- [x] Automated test runner creation
- [x] Validation workflow documentation

### Pending Implementation ⏳

**v0.2 - Real-World Testing**
- [ ] Production environment deployment
- [ ] Performance benchmarking
- [ ] Rule tuning and optimization
- [ ] False positive analysis

**v0.3 - Rule ID Harmonization**
- [ ] Audit rule ID conflicts
- [ ] Define safe ID ranges
- [ ] Update rule files with new IDs
- [ ] Update test scripts and documentation

**Future Components**
- [ ] RADIUS server monitoring
- [ ] VPN concentrator monitoring
- [ ] Wireless controller monitoring
- [ ] Switch syslog monitoring
- [ ] Load balancer security
- [ ] NTP service monitoring
- [ ] Mail server security
- [ ] Proxy server monitoring

## Correlation Architecture

### Current Correlation Matrix

DNS Queries ←→ DHCP Leases ←→ Firewall Blocks ←→ Suricata Alerts
↓ ↓ ↓ ↓
Stork Config ←→ Kea Control ←→ OPNsense Syslog ←→ Endpoint Alerts


### Planned Correlation Expansion

WiFi Auth ←→ RADIUS ←→ VPN Access ←→ DHCP Leases
↓ ↓ ↓ ↓
Switch Port ←→ MAC Addr ←→ Client IP ←→ DNS Queries


## Implementation Priority Matrix

| Component | Security Value | Effort | Dependencies | Release Target |
|-----------|---------------|--------|--------------|----------------|
| Real-World Testing | Critical | Medium | v0.1 Complete | v0.2 |
| Rule ID Fixes | High | Medium | Testing Complete | v0.3 |
| RADIUS | Critical | Medium | None | Phase 2 |
| VPN | Critical | Medium | RADIUS | Phase 2 |
| Switches | High | Low | None | Phase 3 |
| Wireless | High | Medium | RADIUS | Phase 2 |

## Success Metrics & KPIs

### Coverage Metrics
- **Infrastructure Coverage**: % of network layers monitored
- **Service Coverage**: % of critical services with security monitoring
- **Data Source Coverage**: % of potential log sources integrated

### Detection Metrics
- **MTTD**: Mean time to detect common attack patterns
- **Correlation Rate**: % of alerts with cross-service context
- **Coverage Gap**: Time to detect new infrastructure components

### Testing Metrics
- **Test Coverage**: % of components with validation tests
- **Automation Rate**: % of tests automated
- **Validation Time**: Time to validate new implementations

### Operational Metrics
- **False Positive Rate**: < 5% for security rules
- **Alert Volume**: Manageable daily alert count
- **Investigation Time**: Reduced mean time to investigate

## Next Immediate Actions

1. **v0.2**: Deploy in production environment for real-world testing
2. **v0.2**: Conduct performance benchmarking and optimization
3. **v0.2**: Analyze and tune rules based on real traffic patterns
4. **v0.3**: Audit rule ID conflicts with official Wazuh rulesets

## Maintenance & Evolution

### Regular Reviews
- Monthly correlation rule effectiveness analysis
- Quarterly coverage gap assessment
- Bi-annual roadmap revision based on new threats

### Testing Evolution
- Continuous test case expansion
- Automated regression testing
- Red team exercise integration

### Expansion Considerations
- Cloud infrastructure monitoring (AWS/Azure)
- Container orchestration security (Kubernetes)
- IoT/OT network segmentation monitoring
- Zero Trust architecture integration

---
*Last Updated: November 2025*
*Maintainer: spaceplant2*
*Version: 0.1*
*Repository: https://github.com/spaceplant2/Wazuh-Integrations*
