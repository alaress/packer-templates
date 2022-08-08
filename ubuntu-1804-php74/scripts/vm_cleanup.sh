#!/bin/bash

# Remove apt download cache
rm -rf /var/cache/apt/archives/*

# Make sure Udev doesn't block our network
echo "cleaning up udev rules"
rm -rf /dev/.udev/

echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
echo "pre-up sleep 2" >> /etc/network/interfaces

# Zero out the free space to save space in the final image:
echo "Zeroing device to make space..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
