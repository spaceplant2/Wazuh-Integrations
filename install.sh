#!/bin/bash
set -e

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

OSSEC_HOME="/var/ossec"
INSTALL_DIR="$(pwd)"

echo "Installing Wazuh Network Security Integrations..."

# Create directories if they don't exist
mkdir -p "${OSSEC_HOME}/etc/rules"
mkdir -p "${OSSEC_HOME}/etc/decoders"

# Copy rules and decoders
cp ${INSTALL_DIR}/ossec/rules/* ${OSSEC_HOME}/etc/rules/
cp ${INSTALL_DIR}/ossec/decoders/* ${OSSEC_HOME}/etc/decoders/

# Set permissions
chown -R root:wazuh ${OSSEC_HOME}/etc/rules
chown -R root:wazuh ${OSSEC_HOME}/etc/decoders
chmod -R 750 ${OSSEC_HOME}/etc/rules
chmod -R 750 ${OSSEC_HOME}/etc/decoders

# Restart Wazuh manager
systemctl restart wazuh-manager

echo "Installation complete. Run tests to verify:"
echo "cd ossec/tests && ./run-tests.sh"
