#! /bin/bash
# Install the VirtualBox guest additions
# DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential dkms linux-headers-"$(uname -r)" perl linux-headers-generic
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
VBOX_ISO=VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop $VBOX_ISO /mnt
yes|sh /mnt/VBoxLinuxAdditions.run
umount /mnt

#Cleanup VirtualBox
# DEBIAN_FRONTEND=noninteractive apt-get remove -y build-essential dkms linux-headers-"$(uname -r)" perl linux-headers-generic
# DEBIAN_FRONTEND=noninteractive apt-get autoremove -y
rm $VBOX_ISO
