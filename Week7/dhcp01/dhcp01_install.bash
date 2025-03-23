#!/bin/bash
# Script used to setup dhcpd and wazuh agent service onto the dhcp01 device --> **Run as standard user

# Update Packages and install dhcpd
sudo apt update
sudp apt install isc-dhcp-server -y

# Download dhcpd config file
sudo wget -O /etc/dhcp/dhcpdconf "https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/Week7/dhcp01/dhcpd.conf"

# Restart and enable dhcp server (disable ipv6 dhcp server)
sudo systemctl enable isc-dhcp-server
sudo systemctl restart isc-dhcp-server
sudo systemctl disable isc-dhcp-server6

# Set Hostname
sudo hostnamectl set-hostname dhcp01-michael

# Wazuh agent install

sudo systemctl
