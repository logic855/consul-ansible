# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
 
  #config.vm.provision "shell", path: "consul.sh"

 
  config.vm.define "web01", primary: true do |web01|

    web01.vm.box = "ubuntu/trusty64"
    web01.vm.hostname = 'web01'
    web01.vm.box_url = "ubuntu/trusty64"

    web01.vm.network "public_network", ip: "192.168.10.101", :bridge => "en0: Wi-Fi (AirPort)"

    web01.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "web01"]
    end
  end

  config.vm.define "web02" do |web02|

    web02.vm.box = "ubuntu/trusty64"
    web02.vm.hostname = 'web02'
    web02.vm.box_url = "ubuntu/trusty64"

    web02.vm.network "public_network", ip: "192.168.10.102", :bridge => "en0: Wi-Fi (AirPort)"

    web02.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "web02"]
    end
  end

  config.vm.define "web03" do |web03|

    #web03.vm.provision "shell", path: "nginx.sh"

    web03.vm.box = "ubuntu/trusty64"
    web03.vm.hostname = 'web03'
    web03.vm.box_url = "ubuntu/trusty64"

    web03.vm.network "public_network", ip: "192.168.10.103", :bridge => "en0: Wi-Fi (AirPort)"

    web03.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "web03"]
    end
  end

  config.vm.define "ansiblemaster" do |ansiblemaster|

    ansiblemaster.vm.provision "shell", path: "Scripts/ansible.sh"

    ansiblemaster.vm.box = "ubuntu/trusty64"
    ansiblemaster.vm.hostname = 'ansiblemaster'
    ansiblemaster.vm.box_url = "ubuntu/trusty64"

    ansiblemaster.vm.network "public_network", ip: "192.168.10.100", :bridge => "en0: Wi-Fi (AirPort)"

    ansiblemaster.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "ansiblemaster"]
    end
  end

end
