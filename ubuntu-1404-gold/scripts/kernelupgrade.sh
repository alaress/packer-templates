#!/bin/bash

# Update the linux kernel
apt-get -y update
apt-get -y install linux-generic linux-image-generic
apt-get -y autoremove
apt-get clean

reboot
sleep 60
exit
