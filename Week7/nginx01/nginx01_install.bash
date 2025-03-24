#!/bin/bash
# Script used to setup nginx and wazuh agent service onto the dhcp01 device --> **Run as standard user

# Update Packages and install dhcpd
sudo apt update
sudo apt install nginx -y

# Download Nginx Config Files
sudo wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/Week7/nginx01/nginx.conf"
sudo wget -O /var/www/html/index.html "https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/Week7/nginx01/index.html"
sudo wget -O /var/www/html/cool-image.png "https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/Week7/nginx01/cool-image.png"

# Enable and Start server
sudo systemctl enable nginx
sudo systemctl restart nginx

# Set Hostname
sudo hostnamectl set-hostname nginx01-michael

# Wazuh agent install (Debian)
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.7.5-1_amd64.deb && sudo WAZUH_MANAGER='172.16.200.10' WAZUH_AGENT_GROUP='linux' dpkg -i ./wazuh-agent_4.7.5-1_amd64.deb

sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
