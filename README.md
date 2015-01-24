chef-repo
=========
# Description
this is a chef repository in order to build development environment of php or ruby by using vagrant.

VM box is a ubuntu server 14.04

# Environment
    ~> OS X
    ~> ruby 2.0
    ~> gem 2.0

# How it works

### Download and install virtualbox
    https://www.virtualbox.org/wiki/Downloads

### Download and install vagrant
    http://downloads.vagrantup.com/

### Install vagrant omnibus plugin
    vagrant plugin install vagrant-omnibus

### clone this repository
    git clone https://github.com/toshiponnu/chef-repo ~/chef-repo

### launch
    cd ~/chef-repo
    vagrant up

### configure ssh
    vagrant ssh-config --host ubuntu >> ~/.ssh/config
    ssh ubuntu
