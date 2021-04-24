# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  # Network Config
  config.vm.network "private_network", ip: "192.168.33.20"

  #MSSQL Server Port as 1434
  config.vm.network "forwarded_port", guest: 1433, host: 1434
  
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"  
  # config.vm.network "public_network"

  # Synced Folder
  config.vm.synced_folder "./apps", "/var/www/html"

  # VBox Settings
  config.vm.provider "virtualbox" do |vb|
 
    # Customize the amount of RAM and CPU
    vb.memory = 2048
    vb.cpus = 1

  end

  # VM Provisions (Apps)
  config.vm.provision "shell", path: "install.sh"
end
