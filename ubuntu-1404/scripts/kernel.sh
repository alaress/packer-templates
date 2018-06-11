#!/bin/bash

apt-get update
apt-get upgrade -y

# reboot
echo "Rebooting the machine..."
reboot
sleep 60
