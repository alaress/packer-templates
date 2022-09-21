#!/bin/bash

# Record build date
date '+%s' >> /home/vagrant/.vagrant.buildtimestamp

# Download and Install Schoolbox's Repo
echo '# schoolbox-upstream-new
deb https://apt.schoolbox.com.au/upstream bionic bionic' > /etc/apt/sources.list.d/schoolbox-upstream-new.list
wget -qO - http://apt.schoolbox.com.au/schoolbox.key | apt-key add -
apt-get update

# Installing puppet from packages
DEBIAN_FRONTEND=noninteractive apt-get install -y puppet-agent libxext6
/opt/puppetlabs/puppet/bin/gem install lookup_http

# Install some base dependencies
DEBIAN_FRONTEND=noninteractive apt-get install -y gpg software-properties-common vim apt-show-versions
