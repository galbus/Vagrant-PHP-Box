# -*- mode: ruby -*-
# vi: set ft=ruby :

# **********************
# Load Vagrantfile.local
# **********************

begin
  load '../Vagrantfile.local'
  puts "../Vagrantfile.local loaded"
rescue LoadError
  puts "../Vagrantfile.local not found"
  puts "Copy Vagrantfile.local.dist into the project root and edit to and adjust the settings. e.g:"
  puts "  cp Vagrantfile.local.dist ../Vagrantfile.local"
  puts "  vi Vagrantfile.local"
end

Vagrant.configure("2") do |config|

  # **********************
  # Puppet Manifest
  # **********************

  config.vm.provision :puppet do |puppet|
    if File.exists?(File.expand_path("../puppet/manifests/site.pp", __FILE__)) then
      puppet.manifests_path = "../puppet/manifests"
    else
      puppet.manifests_path = "puppet/manifests"
    end
    puppet.manifest_file  = "site.pp"
    puppet.options        = "--verbose --debug"
  end

end
