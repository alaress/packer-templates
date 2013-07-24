packer-templates
==================

Various new and modified [packer.io](https://github.com/mitchellh/packer) templates for building base VM boxes.

## Basics
* Some templates based off definitions from [veewee](https://github.com/jedi4ever/veewee)
* All templates are 64 bit server installs
* Change base config to 2 CPU, 512MB RAM
* Use distribution based Ruby packages where possible
* Use add and install puppet using offical vendor [puppetlabs](http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html) repositories where possible
