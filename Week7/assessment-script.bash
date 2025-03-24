#!/bin/bash
# Script used to download and remotely run assessment install scripts | by Mike N.
# To Use: "wget https://raw.githubusercontent.com/itsmmmike/sec-350/refs/heads/main/Week7/assessment-script.bash" && sudo bash ./assessment-script.bash"

## Pre-Reqs:
# * Basic networking has been configured for nginx01 + dhcp01
# * Local Priv Users successfully created & added to groups
# * Mgmt01 can connect to target systems

# Troubleshooting: Remove old ssh fingerprints
# ssh-keygen -f "/home/michael/.ssh/known_hosts" -R "<IP_of_remote-host_here>"

## Download Script Files and remotely run on target system
ssh -t michael@172.16.150.5 "wget 'https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/Week7/dhcp01/dhcp01_install.bash' && sudo bash dhcp01_install.bash; rm dhcp01_install.bash"
ssh -t michael@172.16.50.3 "wget 'https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/Week7/nginx01/nginx01_install.bash' && sudo bash nginx01_install.bash; rm nginx01_install.bash"
