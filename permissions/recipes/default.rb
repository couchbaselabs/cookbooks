#
# Cookbook Name:: permissions
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

root_files = %w(/etc/chef/validation.pem /etc/chef/client.rb)

root_files.each do |f|
  file f do
    owner "root"
    group 0
    mode "0644"
  end
end
