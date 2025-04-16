#!/bin/bash

# Script used to install Wireguard server for SEC-350 VPN Project
# To Use: wget this file, then Run as sudo --> "bash wireguard_install.bash"

# Useful Resources:
# * https://www.reddit.com/r/WireGuard/comments/fyb7mi/centos_7_kernel_module_problem/

# Installing Wireguard packages
curl -Lo /etc/yum.repos.d/wireguard.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-7/jdoss-wireguard-epel-7.repo

sudo yum update -y
sudo yum install wireguard-dkms wireguard-tools -y
sudo yum install epel-release -y

# Var used to retrieve the name of the local active network adapter
netadapter=$(ip a | awk '/inet.*brd/{print $NF}')

# Generate Private/Public KeyPairs for Wireguard Server & Client
sudo wg genkey | sudo tee /etc/wireguard/srvkey-private | sudo wg pubkey | sudo tee /etc/wireguard/srvkey-public
sudo wg genkey | sudo tee /etc/wireguard/client01-private | sudo wg pubkey | sudo tee /etc/wireguard/client01-public

# Server Configuration
sudo cat > /etc/wireguard/wg0.conf << EOF
[Interface]
Address = 10.10.10.1/24
SaveConfig = true
PrivateKey = $(sudo cat /etc/wireguard/srvkey-private)
ListenPort = 51820
PreUp = sysctl -w net.ipv4.ip_forward=1
PreUp = iptables -t nat -A PREROUTING -p tcp -d 10.10.10.1 --dport 3389 -j DNAT --to-destination 172.16.200.11:3389
PreUp = iptables -t nat -A POSTROUTING -o $netadapter
PostDown = iptables -t nat -D PREROUTING -p tcp -d 10.10.10.1 --dport 3389 -j DNAT --to-destination 172.16.200.11:3389
PostDown = iptables -t nat -D POSTROUTING -o $netadapter

[Peer]
PublicKey = $(sudo cat /etc/wireguard/client01-public)
AllowedIPs = 10.10.10.2/24
PersistentKeepalive = 25
EOF

# Peer Configuration
sudo cat > /etc/wireguard/client01.conf << EOF
[Interface]
PrivateKey = $(sudo cat /etc/wireguard/client01-private)
Address = 10.10.10.2/24

[Peer]
PublicKey = $(sudo cat /etc/wireguard/srvkey-public)
Allowed IPs = 0.0.0.0/0
Endpoint = 10.0.17.160:51820
PersistentKeepalive = 25
EOF

# Start Wireguard
sudo wg-quick up wg0
