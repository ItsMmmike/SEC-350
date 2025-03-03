#!/bin/bash
# Script used to configure the OSQuery service on a Rocky-Based System and Update the Wazuh-Agent Configuration to send osquery event logs to Wazuh Server
# To Use: Download and run script as sudo user --> "sudo curl -O https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/Week5/enable-wazuh-osquery.bash && sudo bash ./enable-wazuh-osquery.bash"

# Source Reference: https://documentation.wazuh.com/4.7/user-manual/capabilities/malware-detection/osquery.html#configuration

# Install OS Query
curl -L https://pkg.osquery.io/rpm/GPG | sudo tee /etc/pki/rpm-gpg/RPM-GPG-KEY-osquery
sudo yum-config-manager --add-repo https://pkg.osquery.io/rpm/osquery-s3-rpm.repo
sudo yum-config-manager --enable osquery-s3-rpm-repo
sudo yum install osquery -y

# Add OSQuery Configuration Files and move to location
curl -L https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/Week5/osquery.conf | sudo tee /etc/osquery/osquery.conf

# Enable the Service
sudo systemctl enable osqueryd
#sudo systemctl start osqueryd

# Update Wazuh-Agent Configuration File
curl -L https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/Week5/wazuh-agent-osquery.conf | sudo tee /var/ossec/etc/ossec.conf

# Restart Wazuh-Agent
sudo systemctl restart wazuh-agent
