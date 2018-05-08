#!/bin/bash

# Record build date
date '+%s' >> /home/vagrant/.vagrant.buildtimestamp

# Set up sudo
echo %vagrant ALL=NOPASSWD:ALL > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# Setup sudo to allow no-password sudo for "sudo"
usermod -a -G sudo vagrant

# Installing vagrant keys
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# Download and Install PuppetLabs Offical Repository
# TODO: no Bionic version yet
#wget http://apt.puppetlabs.com/puppetlabs-release-bionic.deb
#dpkg -i puppetlabs-release-bionic.deb
#rm -f puppetlabs-release-bionic.deb

# Install NFS for Vagrant
apt-get update
apt-get install -y nfs-common

# Installing puppet from packages
apt-get install -y puppet facter

# Install some base dependencies
apt-get install -y gpg software-properties-common vim
