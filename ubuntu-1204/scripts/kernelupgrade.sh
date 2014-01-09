#!/bin/bash

# Update the linux kernel
apt-get -y update
apt-get -y install linux-generic-lts-raring linux-image-generic-lts-raring
apt-get -y autoremove
apt-get clean

reboot
sleep 60
exit
