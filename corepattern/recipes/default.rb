#
# Cookbook Name:: corepattern
# Recipe:: default
#
# All rights reserved - Do Not Redistribute
#

execute "set core pattern" do
  command "sysctl -w kernel.core_pattern=#{node['corepattern']}"
end
