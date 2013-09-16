#!/bin/bash

# Update the linux kernel
apt-get -y update
apt-get -y install linux-generic-lts-quantal linux-image-generic-lts-quantal
apt-get -y autoremove
apt-get clean

reboot
sleep 60
exit