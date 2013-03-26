#
# Cookbook Name:: python26
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node['platform']
when "centos"
  %w{python26 python26-devel python26-setuptools}.each do |pkg|
    package pkg do
      action :install
    end
  end
end
