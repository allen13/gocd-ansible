# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'
require_relative './vagrant/shared.rb'

Vagrant.configure("2") do |config|
  create_vm(config, name: "go-server", id: 1, memory: 1024)
  create_vm(config, name: "go-agent", id: 2, memory: 1024)
end
