packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
  }
}

source "vagrant" "jammy" {
  communicator = "ssh"
  source_path = "ubuntu/jammy64"
  provider = "virtualbox"
  template = "./vagrantfile.template"
  box_name = "ubuntu-2204-php80"
  ssh_timeout = "10s"
}

variable "puppetRepo" {
  type = string
}

variable "schoolboxRepo" {
  type = string
}

build {
  sources = ["source.vagrant.jammy"]

  provisioner "shell" {
    execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    script            = "scripts/kernel.sh"
  }

  provisioner "shell" {
    inline = [
      "sudo reboot"
    ]
    expect_disconnect = true
    pause_after = "30s"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    script          = "scripts/vagrant.sh"
  }

  provisioner "file" {
    destination = "/tmp/private_key.pkcs7.pem"
    source = "${var.schoolboxRepo}/vagrantcache/private_key.pkcs7.pem"
  }

  provisioner "file" {
    destination = "/tmp/hieradata"
    source      = "${var.puppetRepo}/environments/staging/hieradata"
  }

  provisioner "file" {
    destination = "/tmp/puppet-modules"
    source      = "${var.puppetRepo}/environments/staging/modules"
  }

  provisioner "file" {
    destination = "/tmp/hiera.yaml"
    source      = "${var.puppetRepo}/environments/staging/hiera.yaml"
  }

  provisioner "file" {
    destination = "/tmp/site.pp"
    source      = "${var.puppetRepo}/environments/staging/manifests/site.pp"
  }

  provisioner "file" {
    destination = "/tmp/keys"
    source      = "${var.puppetRepo}/keys"
  }

  provisioner "shell" {
    inline = [
      "sudo mkdir -vp /etc/puppetlabs/code/hieradata", 
      "sudo mkdir -vp /etc/puppetlabs/code/hieradata/node", 
      "sudo mkdir -vp /etc/puppetlabs/code/hieradata/os", 
      "sudo mkdir -vp /etc/puppetlabs/code/manifests", 
      "sudo mkdir -vp /etc/puppetlabs/code/modules", 
      "sudo mkdir -vp /etc/puppetlabs/puppet/eyaml", 
      "sudo mkdir -vp /usr/share/schoolbox",
      "sudo cp -v /tmp/hieradata/common.yaml /etc/puppetlabs/code/hieradata/", 
      "sudo cp -v /tmp/hieradata/os/*.yaml /etc/puppetlabs/code/hieradata/os/", 
      "sudo cp -v /tmp/hieradata/node/*vagrant.yaml /etc/puppetlabs/code/hieradata/node/", 
      "sudo cp -r /tmp/puppet-modules/* /etc/puppetlabs/code/modules", 
      "sudo cp /tmp/hiera.yaml /etc/puppetlabs/code/hiera.yaml", 
      "sudo cp /tmp/site.pp /etc/puppetlabs/code/manifests/site.pp", 
      "sudo mv -v /tmp/private_key.pkcs7.pem /tmp/keys",
      "sudo cp -v /tmp/keys/* /etc/puppetlabs/puppet/eyaml",
      "rm -rf /tmp/{hieradata,puppet-modules,hiera.yaml,site.pp,puppet,keys}",
      ]
  }

  provisioner "shell" {
    inline =  [
      "echo 'vagrant'|sudo -S FACTER_primary_php_majver=8.0 /opt/puppetlabs/bin/puppet apply --verbose --modulepath=/etc/puppetlabs/code/modules --hiera_config=/etc/puppetlabs/code/hiera.yaml /etc/puppetlabs/code/manifests/site.pp",
      "sudo docker pull gotenberg/gotenberg:8.0.3"
    ]
  }

  provisioner "shell" {
    inline = [
      "rm -rf /etc/puppetlabs/code/{hieradata,modules,hiera.yaml,manifests}",
      "sudo rm -rf /etc/puppetlabs/puppet/eyaml"
    ]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts         = ["scripts/vm_cleanup.sh"]
  }
}
