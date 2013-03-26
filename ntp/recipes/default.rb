#
# Cookbook Name:: ntp
# Recipe:: default
# Author:: Joshua Timberman (<joshua@opscode.com>)
#
# Copyright 2009, Opscode, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node[:platform]
when "ubuntu","debian"
  package "ntpdate" do
    action :install
  end
end

package "ntp" do
  action :install
  not_if { platform?("mac_os_x") }
end

service node[:ntp][:service] do
  action :start
  not_if { platform?("mac_os_x") }
end

template "/etc/ntp.conf" do
  source "ntp.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :run, "execute[restorecon]", :immediately
  notifies :restart, resources(:service => node[:ntp][:service])
  not_if { platform?('mac_os_x') }
end

# Make selinux happy.
execute "restorecon" do
  command "/sbin/restorecon -v /etc/ntp.conf || exit 0"
  action :nothing
  only_if { File.exists? '/sbin/restorecon' }
end
