# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  
  # Customize the number of cores and amount of memory on the VM:
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "1"
    vb.memory = "512"
  end

  # Setup default packages and configuration files
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y build-essential gcc-multilib emacs htop gdb git
    for i in `ls /home`; do echo 'cd /vagrant' >>/home/${i}/.bashrc; done
    for i in `ls /home`; do curl http://www.cse.psu.edu/~tuz68/.emacs 2>/dev/null >/home/${i}/.emacs; chown ${i}:${i} /home/${i}/.emacs; done
    for i in `ls /home`; do curl https://raw.githubusercontent.com/mitthu/cmpsc473_spring18/master/base/dot_vimrc 2>/dev/null >/home/${i}/.vimrc; chown ${i}:${i} /home/${i}/.vimrc; done
  SHELL
end
