#
# Cookbook Name:: buildslave
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform?('solaris2')
  home_dir = "/export/home/buildbot"
elsif platform?('mac_os_x')
  home_dir = "/Users/buildbot"
else
  home_dir = "/home/buildbot"
end

group "buildbot" do
  gid 1001
end

user "buildbot" do
  uid 1001
  gid 'buildbot'
  home home_dir
  shell "/bin/bash"
  supports :manage_home => true
end

cookbook_file "#{home_dir}/.ssh/known_hosts" do
  owner 1001
  group 'buildbot'
  mode "0644"
end

cookbook_file "#{home_dir}/.ssh/id_dsa" do
  owner 1001
  group 'buildbot'
  mode "0600"
end

cookbook_file "#{home_dir}/.ssh/id_dsa.pub" do
  owner 1001
  group 'buildbot'
  mode "0644"
end

easy_install_package "buildbot-slave"
