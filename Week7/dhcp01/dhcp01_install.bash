#!/bin/bash
# Script used to setup dhcpd and wazuh agent service onto the dhcp01 device --> **Run as standard user

# Update Packages and install dhcpd
sudo apt update
sudo apt install isc-dhcp-server -y
sudo apt install vim -y

# Download dhcpd config file
sudo wget -O /etc/dhcp/dhcpd.conf "https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/Week7/dhcp01/dhcpd.conf"

# Restart and enable dhcp server (disable ipv6 dhcp server)
sudo systemctl enable isc-dhcp-server
sudo systemctl disable isc-dhcp-server6
sudo systemctl restart isc-dhcp-server

# Set Hostname
sudo hostnamectl set-hostname dhcp01-michael

# Wazuh agent install (Debian)
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.7.5-1_amd64.deb && sudo WAZUH_MANAGER='172.16.200.10' WAZUH_AGENT_GROUP='linux' dpkg -i ./wazuh-agent_4.7.5-1_amd64.deb

sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
