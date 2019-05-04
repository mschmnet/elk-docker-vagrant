# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Port 5601 used by Kibana
  config.vm.network "forwarded_port", guest: 5601, host: 5601, host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = 8192
  end

  # config.disksize requires the the vagrant-disksize plugin
  # Install with vagrant plugin install vagrant-disksize
  config.disksize.size = '200GB'

  # Enables execution behind a proxy. It can be used setting the environment variables
  # VAGRANT_HTTP_PROXY and VAGRANT_HTTPS_PROXY in the shell
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = nil 
    config.proxy.https    = nil 
    config.proxy.no_proxy = "localhost,127.0.0.1" 
  end   

  # Requires vagrant 2.2.1 at least: https://github.com/hashicorp/vagrant/pull/10399
  config.vm.provision "shell", privileged: false, path: "provision.sh", reset: true
  config.vm.provision "shell", privileged: false, path: "provision-docker.sh"
end
