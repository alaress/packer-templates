#!/bin/bash

# switch to the nz mirror since more reliable :(
sed -i 's/au.arc/nz.arc/g' /etc/apt/sources.list

# install the backported kernel
apt-get update
apt-get install -y linux-image-generic-lts-trusty linux-headers-generic-lts-trusty
apt-get upgrade -y

# reboot
echo "Rebooting the machine..."
reboot
sleep 60
