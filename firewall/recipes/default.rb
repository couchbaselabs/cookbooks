#
# Cookbook Name:: firewall
# Recipe:: default
#
# All rights reserved - Do Not Redistribute
#

case node['platform']
when 'fedora'
  service 'iptables' do
    action :stop
  end
end
