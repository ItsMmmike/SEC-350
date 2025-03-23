#!/bin/bash
# Script used to download and remotely run assessment install scripts | by Mike N.
# To Use: "wget https://raw.githubusercontent.com/itsmmmike/sec-350/refs/heads/main/Week7/assessment-script.bash" && sudo bash ./assessment-script.bash"

## Pre-Reqs:
# * Basic networking has been configured for nginx01 + dhcp01
# * Local Priv Users successfully created & added to groups
# * Mgmt01 can connect to target systems

# Download Script Files to local system
wget "https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/Week7/dhcp01/dhcp01_install.bash"
#wget ""

# Remotely run scripts on target systems via SSH
ssh michael@172.16.150.5 "sudo bash -s" < ./dhcp01_install.bash

# Remove scirpt files after they are run
rm ./dhcp01_install.bash
