#!/bin/bash

# Record build date
date '+%s' >> /home/vagrant/.vagrant.buildtimestamp

# Download and Install Schoolbox's Repo
DEBIAN_FRONTEND=noninteractive apt-get install -y gpg software-properties-common vim apt-show-versions apt-transport-https
echo "# schoolbox-upstream-new
deb [signed-by=/usr/share/keyrings/schoolbox.gpg] https://apt.schoolbox.com.au/upstream $(lsb_release -cs) $(lsb_release -cs)" > /etc/apt/sources.list.d/schoolbox-upstream-new.list
wget -qO - https://apt.schoolbox.com.au/schoolbox.key | gpg --dearmor | tee /usr/share/keyrings/schoolbox.gpg > /dev/null
apt-get update

# Installing puppet from packages
DEBIAN_FRONTEND=noninteractive apt-get install -y puppet-agent 
/opt/puppetlabs/puppet/bin/gem install lookup_http
