# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network :forwarded_port, guest: 4000, host: 4000

  config.vm.network "private_network", ip: "192.168.80.10"

  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    virtualbox.customize ["modifyvm", :id, "--memory", "512"]
    virtualbox.customize ["modifyvm", :id, "--cpus", "1"]
  end

  config.vm.synced_folder "./", "/var/www/blog/", id: "blog", type: nil,
    group: 'vagrant', owner: 'vagrant', mount_options: ["dmode=775", "fmode=764"]

  config.vm.provision "shell", path: "bin/provision.sh"
end
