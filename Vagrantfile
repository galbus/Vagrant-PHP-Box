# -*- mode: ruby -*-
# vi: set ft=ruby :

begin
  load '../Vagrantfile.synced_folders'
  puts "../Vagrantfile.synced_folders loaded"
rescue LoadError
  puts "../Vagrantfile.synced_folders not found"
  puts "Copy Vagrantfile.synced_folders.dist into the project root and edit to set up synced folders. e.g:"
  puts "  cp Vagrantfile.synced_folders.dist ../Vagrantfile.synced_folders"
  puts "  vi Vagrantfile.synced_folders"
end

Vagrant.configure("2") do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :private_network, ip: "10.33.33.10"
  config.vm.hostname = "app.local"

  config.vm.synced_folder "../", "/var/www/app.local",
    :nfs => false

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision :shell do |shell|
    shell.inline = "mkdir -p /etc/puppet/modules;
                    puppet module install puppetlabs/apache;
                    puppet module install puppetlabs/mysql;
                    puppet module install thias/php;
                    puppet module install leinaddm/htpasswd;"
  end

  config.vm.provision :puppet do |puppet|
    if File.exists?(File.expand_path("../puppet/manifests/site.pp", __FILE__)) then
      puppet.manifests_path = "../puppet/manifests"
    else
      puppet.manifests_path = "puppet/manifests"
    end
    puppet.manifest_file  = "site.pp"
#   puppet.options        = "--verbose --debug"
  end

end
