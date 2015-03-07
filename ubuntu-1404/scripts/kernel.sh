#!/bin/bash

# switch to the nz mirror since more reliable :(
sed -i 's/au.arc/nz.arc/g' /etc/apt/sources.list

apt-get update
apt-get upgrade -y

# reboot
echo "Rebooting the machine..."
reboot
sleep 60
