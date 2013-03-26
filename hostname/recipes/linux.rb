#
# Cookbook Name:: hostname
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

file "/etc/hostname" do
  content "#{node[:hostinfo][:name]}\n"
  owner "root"
  group "root"
  mode "0644"
  notifies :run, "execute[change_hostname]"
end

template "/etc/hosts" do
  source "hosts.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
    :hostname => node[:hostinfo][:name],
    :address => node[:ipaddress]
  )
end

execute "change_hostname" do
  command "/bin/hostname -F /etc/hostname"
  action :nothing
end
