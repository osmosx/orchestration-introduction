# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "spox/ubuntu-arm"
  config.vm.box_version = "1.0.0"
  config.vm.synced_folder ".", "/vagrant_data", create: true
  config.vm.define "manager01" do |manager|
    # nginx's ports
    manager.vm.network :forwarded_port, guest: 8081, host: 8081
    manager.vm.network :forwarded_port, guest: 8087, host: 8087
    # portainer's ports
    manager.vm.network :forwarded_port, guest: 9000, host: 9000
    manager.vm.network :forwarded_port, guest: 8000, host: 8000
    manager.vm.network :forwarded_port, guest: 9443, host: 9443
    manager.vm.provider :vmware_desktop do |vmware|
      vmware.gui = true
      vmware.cpus = 2
      vmware.vmx["ethernet0.virtualdev"] = "vmxnet3"
      vmware.ssh_info_public = true
      vmware.linked_clone = false
    end
    manager.vm.hostname = "manager01"
    manager.vm.provision "shell", inline: <<-SHELL
      sudo bash /vagrant_data/install_docker.sh
      sudo bash /vagrant_data/init_swarm.sh > /vagrant_data/join_swarm.txt
    SHELL
  end

  config.vm.define "worker01" do |worker1|
    worker1.vm.provider :vmware_desktop do |vmware|
      vmware.gui = true
      vmware.cpus = 2
      vmware.vmx["ethernet0.virtualdev"] = "vmxnet3"
      vmware.ssh_info_public = true
      vmware.linked_clone = false
    end
    worker1.vm.hostname = "worker01"
    worker1.vm.provision "shell", inline: <<-SHELL
      sudo bash /vagrant_data/install_docker.sh
      sudo bash /vagrant_data/init_swarm.sh
    SHELL
  end

  config.vm.define "worker02" do |worker2|
    worker2.vm.provider :vmware_desktop do |vmware|
      vmware.gui = true
      vmware.cpus = 2
      vmware.vmx["ethernet0.virtualdev"] = "vmxnet3"
      vmware.ssh_info_public = true
      vmware.linked_clone = false
    end
    worker2.vm.hostname = "worker02"
    worker2.vm.provision "shell", inline: <<-SHELL
      sudo bash /vagrant_data/install_docker.sh
      sudo bash /vagrant_data/init_swarm.sh
    SHELL
  end
end
