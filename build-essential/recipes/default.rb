#
# Cookbook Name:: build-essential
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
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
#

case node['platform']
when "ubuntu","debian"
  %w{build-essential binutils-doc devscripts ruby-dev rake libncurses5-dev openssl libssl-dev git-core libtool python-setuptools python-dev s3cmd debhelper libsasl2-dev scons}.each do |pkg|
    package pkg do
      action :install
    end
  end
when "centos","redhat","fedora","amazon"
  %w{gcc gcc-c++ kernel-devel make ncurses-devel openssl-devel rpm-build python-setuptools python-devel git cyrus-sasl-devel openssl-devel libtool scons}.each do |pkg|
    package pkg do
      action :install
    end
  end
  bash "install_s3cmd" do
    user "root"
    cwd "/tmp"
    code <<-EOH
    (cd /tmp;rm -rf /tmp/s3cmd;git clone git://github.com/couchbaselabs/s3cmd.git;)
    (cd /tmp/s3cmd;git reset --hard eb9330fffd0214259a079f550c2c5ed27f959972;)
    (cd /tmp/s3cmd;sudo python setup.py install;)
    EOH
  end
end

case node['platform']
when "centos","amazon","fedora"
  bash "install automake-1.11" do
     user "root"
     cwd = "/tmp"
     code <<-EOH
     (cd /tmp;rm -f automake-1.11.1.tar.bz2;wget http://ftp.gnu.org/gnu/automake/automake-1.11.1.tar.bz2;)
     (cd /tmp;rm -rf /tmp/automake-1.11.1;tar -xvf automake-1.11.1.tar.bz2;)
     (cd /tmp/automake-1.11.1;./configure;make;make install;)
     EOH
  end
end

case node['platform']
when "centos","amazon","fedora"
  bash "install libtool" do
     user "root"
     cwd = "/tmp"
     code <<-EOH
     (cd /tmp;rm -rf libtool-2.4.2.tar.gz;wget http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz;)
     (cd /tmp;rm -rf libtool-2.4.2;tar -xvf libtool-2.4.2.tar.gz;)
     (cd /tmp/libtool-2.4.2;./configure;make;make install;)
     EOH
  end
end

unless node['platform'] == 'mac_os_x'
  package "autoconf" do
    action :install
  end

  package "flex" do
    action :install
  end

  package "bison" do
    action :install
  end
end

case node['platform']
when "ubuntu","debian","centos","redhat","fedora","amazon"
  bash "chmod_opt" do
    user "root"
    cwd "/tmp"
    code "chmod a+w /opt"
  end
end

cookbook_file "/usr/bin/repo" do
  owner 0
  group 0
  mode "0755"
end

gem_package "rake"
