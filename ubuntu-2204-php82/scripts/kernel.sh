#!/bin/bash
rm -rf /var/lib/apt/lists/*
DEBIAN_FRONTEND=noninteractive sudo apt-get clean
DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# # reboot
# echo "Rebooting the machine..."
# reboot
