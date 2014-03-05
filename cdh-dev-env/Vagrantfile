# -*- mode: ruby -*-
# # vi: set ft=ruby :

# Provisioning shell script
$provisioner = <<SCRIPT
  # Build the apache container
  docker build -t pdmp/oracle-jdk7 /home/core/share/pdmp-layer-docker/oracle-jdk7
  docker build -t pdmp/cdh-pseudo-dist /home/core/share/pdmp-layer-docker/cdh-pseudo-dist 
  # Switch to root for setting up systemd
  #sudo -i
  # Copy the apache service into place
  cp share/cdh.service /media/state/units/cdh.service
  # Start for the first time (will start automatically on subsequent reboots)
  systemctl restart local-enable.service
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "coreos"
  config.vm.box_url = "http://storage.core-os.net/coreos/amd64-generic/dev-channel/coreos_production_vagrant.box"

  # Uncomment below to enable NFS for sharing the host machine into the coreos-vagrant VM.
  config.vm.network "private_network", ip: "172.12.8.150"
  config.vm.synced_folder ".", "/home/core/share", id: "core", :nfs => true,  :mount_options   => ['nolock,vers=3,udp']

  # Fix docker not being able to resolve private registry in VirtualBox
  config.vm.provider :virtualbox do |vb, override|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.provider :vmware_fusion do |vb, override|
    override.vm.box_url = "http://storage.core-os.net/coreos/amd64-generic/dev-channel/coreos_production_vagrant_vmware_fusion.box"
  end

  # plugin conflict
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  config.vm.network "forwarded_port", guest: 80, host: 8081
  config.vm.network "forwarded_port", guest: 50030, host: 50030
  config.vm.network "forwarded_port", guest: 50060, host: 50060
  config.vm.network "forwarded_port", guest: 8021, host: 8021
  config.vm.network "forwarded_port", guest: 9290, host: 9290
  config.vm.network "forwarded_port", guest: 50070, host: 50070, host_ip: "127.0.0.1"

  # Provision
  config.vm.provision "shell", inline: $provisioner
end
