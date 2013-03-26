#
# Cookbook Name:: autofs
# Recipe:: default
#
# Copyright 2010, 37signals
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
when "ubuntu","debian"
  package "nfs-common"
  include_recipe "autofs::linux"
when "redhat","centos","fedora"
  package "nfs-utils"
  include_recipe "autofs::linux"
when "mac_os_x"
  include_recipe "autofs::mac_os_x"
end
