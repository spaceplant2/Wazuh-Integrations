# Wazuh Network Infrastructure Monitoring - Ansible Deployment

## Overview
Ansible automation for deploying Wazuh decoders, rules, and test scripts for comprehensive network infrastructure monitoring.

## Quick Start

### Prerequisites
- Ansible 2.9+
- SSH access to Wazuh servers
- sudo privileges on target systems

### Basic Deployment
```bash
# Deploy everything
ansible-playbook -i inventories/production playbooks/deploy-network-monitoring.yml

# Deploy without tests
ansible-playbook -i inventories/production playbooks/deploy-network-monitoring.yml --skip-tags test

# Deploy specific components only
ansible-playbook -i inventories/production playbooks/deploy-network-monitoring.yml --tags "dns,dhcp"
