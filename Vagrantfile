# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

nproc = ENV["NPROC"] || 4

Vagrant.configure("2") do |config|
  config.vm.box = "nixbox-x86_64" 
  
  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = "8192"
    v.cpus = nproc
  end

  config.vm.synced_folder "~/private/projects/fork-nixpkgs", "/usr/local/src/pkgs"

  config.ssh.insert_key = false
end
