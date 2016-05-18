# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "hvbench-ctrl" do |benchctrl|
    benchctrl.vm.box = "ubuntu/trusty64"
    benchctrl.vm.hostname = "hvbench"

    benchctrl.vm.provision :shell, path: "hvbench-ctrl/provision.sh"
    benchctrl.vm.provision :shell, path: "hvbench-ctrl/provision_user.sh", privileged: false

    benchctrl.vm.network "private_network", ip: "192.168.34.10"

    benchctrl.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
  end

  config.vm.define "hvbench" do |bench|
    bench.vm.box = "ubuntu/trusty64"
    bench.vm.hostname = "hvbench"

    bench.vm.provision :shell, path: "hvbench/provision.sh"
    bench.vm.provision :shell, path: "hvbench/provision_user.sh", privileged: false

    bench.vm.network "private_network", ip: "192.168.34.11"

    bench.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
  end

  config.vm.define "hv-fv" do |hv_fv|
    hv_fv.vm.box = "ubuntu/trusty64"
    hv_fv.vm.hostname = "hv-fv"

    hv_fv.vm.provision :shell, path: "hv_fv/provision.sh"

    hv_fv.vm.network "private_network", ip: "192.168.34.12"
    hv_fv.vm.provision :shell, path: "hv_fv/provision_user.sh", privileged: false

    hv_fv.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "2"
    end
  end

  config.vm.define "mininet" do |mininet|
    mininet.vm.box = "ubuntu/trusty64"
    mininet.vm.hostname = "mininet"

    mininet.vm.provision :shell, path: "mininet/provision.sh"

    mininet.vm.network "private_network", ip: "192.168.34.13"

    mininet.vm.provider "virtualbox" do |vb|
      vb.memory = "1500"
    end
  end

end

