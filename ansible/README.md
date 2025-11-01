# Wazuh Network Infrastructure Monitoring - Ansible Deployment

## Initial Setup

### 1. Clone and Configure
```bash
git clone <repository>
cd ansible

# Copy template files
cp inventories/production/hosts.example inventories/production/hosts
cp inventories/production/group_vars/wazuh_servers.yml.example inventories/production/group_vars/wazuh_servers.yml
cp inventories/production/group_vars/all.yml.example inventories/production/group_vars/all.yml

# Edit configuration files
edit inventories/production/hosts
edit inventories/production/group_vars/wazuh_servers.yml
