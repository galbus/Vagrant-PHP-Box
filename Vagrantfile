# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :private_network, ip: "10.33.33.10"
  config.vm.hostname = "app.local"

  config.vm.synced_folder "../", "/var/www/app.local",
    :nfs => false

  config.vm.synced_folder "../data", "/var/www/app.local/data",
    :owner => 'vagrant',
    :group => 'www-data',
    :mount_options => ['dmode=775','fmode=664'],
    :nfs => false

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "512"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision :shell do |shell|
    shell.inline = "mkdir -p /etc/puppet/modules;
                    puppet module install puppetlabs/apache --version 0.11.0;
                    puppet module install puppetlabs/mysql --version 2.1.0;
                    puppet module install thias/php --version 0.3.9
                    puppet module install leinaddm/htpasswd --version 0.0.2;"
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
