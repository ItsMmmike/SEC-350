#!/bin/bash


# Set Hostname
sudo hostnamectl set-hostname dhcp01-michael

# Wazuh agent install (Debian)
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.7.5-1_amd64.deb && sudo WAZUH_MANAGER='172.16.200.10' WAZUH_AGENT_GROUP='linux' dpkg -i ./wazuh-agent_4.7.5-1_amd64.deb

sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
