# -*- mode: ruby -*-
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # vm
  config.vm.define :myworkspace do |myworkspace|
    myworkspace.vm.box = "centos66"
    myworkspace.vm.box_url = "https://atlas.hashicorp.com/nrel/boxes/CentOS-6.6-x86_64/versions/1.0.0"
    myworkspace.vm.network :private_network, ip: "192.168.53.11"
  end

  # provision
  config.vm.provision "shell" do |s|
    s.path   = "workspace.sh"
    s.inline = $script
  end

end