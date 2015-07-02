require 'rbconfig'

def create_vm(config, options = {})
  dirname = File.dirname(__FILE__)
  config.vm.synced_folder "#{dirname}/..", '/vagrant', disabled: false
  config.ssh.password = 'vagrant'

  name = options.fetch(:name, "node")
  id = options.fetch(:id, 1)
  disk2 = options.fetch(:disk2, 0)
  vm_name = "%s-%02d" % [name, id]

  memory = options.fetch(:memory, 1024)
  cpus = options.fetch(:cpus, 1)
  private_net = options.fetch(:private_net, true)

  config.vm.define vm_name do |config|
    config.vm.box = "chef/centos-7.0"
    config.vm.hostname = vm_name

    public_ip = "192.168.1.10#{id}"
    config.vm.network :private_network, ip: public_ip, netmask: "255.255.255.0"

    if private_net
      private_ip = "192.168.2.10#{id}"
      config.vm.network :private_network, ip: private_ip, netmask: "255.255.255.0"
    end

    config.vm.provider :virtualbox do |vb|
      vb.memory = memory
      vb.cpus = cpus
      vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
      vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]

      if RbConfig::CONFIG['host_os'].downcase =~ /mingw|mswin/
        vb.gui = true
      end
    end
  end
end
