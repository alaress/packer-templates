#!/bin/bash

# switch to the nz mirror since more reliable :(
sed -i 's/au.arc/nz.arc/g' /etc/apt/sources.list

# Update the linux kernel
apt-get -y update
apt-get -y install linux-generic-lts-trusty linux-image-generic-lts-trusty
apt-get -y autoremove
apt-get clean

reboot
sleep 60
exit
