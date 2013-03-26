# -*- coding: undecided -*-
#
# Cookbook Name:: sshd
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

service node[:ssh][:service] do
  action [ :enable, :start ]
  not_if { platform?('mac_os_x') }
end

filename = "/etc/ssh/sshd_config"
if platform?("mac_os_x")
  filename = "/etc/sshd_config"
end

template filename do
  source "sshd_config.erb"
  owner "root"
  group 0
  mode "0644"
  notifies :restart, resources(:service => node[:ssh][:service])
end
