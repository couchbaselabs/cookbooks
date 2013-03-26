#
# Cookbook Name:: dev-box-couchbase-2.0
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

case node['platform']
when "ubuntu","debian"
  %w{build-essential binutils-doc devscripts ruby-dev rake libncurses5-dev openssl libssl-dev git-core libtool python-setuptools python-dev s3cmd debhelper libsasl2-dev scons libevent-1.4-2 libevent-dev openjdk-6-jre openjdk-6-jdk ccache screen}.each do |pkg|
    package pkg do
      action :install
    end
  end
when "centos","redhat","fedora","amazon"
  %w{gcc gcc-c++ kernel-devel make ncurses-devel openssl-devel rpm-build python-setuptools python-devel git cyrus-sasl-devel openssl-devel libtool scons gcc44 gcc44-c++ libevent libevent-devel python26 python26-devel python26-setuptools screen java-1.6.0-openjdk java-1.6.0-openjdk-devel ccache}.each do |pkg|
    package pkg do
      action :install
    end
  end
end


case node['platform']
when "centos","amazon","fedora","ubuntu"
  if not File.exists?('/usr/local/bin/erl')
     bash "install erlang R15B" do
        user "root"
        cwd = "/tmp"
        code <<-EOH
        (cd /tmp;rm -rf otp*;wget http://www.erlang.org/download/otp_src_R15B.tar.gz;)
        (cd /tmp;tar -xvf otp_src_R15B.tar.gz;)
        (cd /tmp/otp_src_R15B;touch lib/wx/SKIP;touch lib/jinterface/SKIP;touch lib/megaco/SKIP;./configure;make;make install;)
        EOH
     end
   end
end

case node['platform']
when "centos","amazon","fedora","ubuntu"
  if not File.exists?('/usr/local/lib/libsnappy.so')
     bash "install snappy" do
        user "root"
        cwd = "/tmp"
        code <<-EOH
        (cd /tmp; rm -rf snappy-1.0.5*;wget http://snappy.googlecode.com/files/snappy-1.0.5.tar.gz;tar -xvf snappy-1.0.5.tar.gz;)
        (cd /tmp/snappy-1.0.5;./configure;make;make install;)
        EOH
     end
  end
end

case node['platform']
when "centos","amazon","fedora","ubuntu"
  if not File.exists?('/usr/local/lib/libtcmalloc_minimal.so')
     bash "install tcmalloc-2.0" do
        user "root"
        cwd = "/tmp"
        code <<-EOH
        (cd /tmp;rm -rf gperftools*;wget http://gperftools.googlecode.com/files/gperftools-2.0.tar.gz;)
        (cd /tmp;tar -xvf gperftools-2.0.tar.gz;)
        (cd /tmp;cd gperftools-2.0;./configure  --disable-static --enable-minimal;make;sudo make libtcmalloc_minimal.la;)
        EOH
     end 
  end
end

case node['platform']
when "centos","amazon","fedora","ubuntu"
  if not File.exists?('/usr/local/lib/libv8.so')
    bash "install v8" do
      user "root"
      cwd = "/tmp"
      code <<-EOH
      (cd /tmp;rm -rf v8*;git clone git://github.com/couchbase/v8.git;)
      (cd /tmp/v8;scons -j 4 arch=x64 mode=release library=shared;cp libv8* /usr/lib/;cp include/* /usr/include/;)
      EOH
    end 
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
when "centos","amazon","fedora","ubuntu"
  if not File.exists?('/usr/local/lib/libcurl.so')
    bash "install curl 7.21.4" do
      user "root"
      cwd = "/tmp"
      code <<-EOH
      (cd /tmp;rm -rf curl*;wget http://curl.haxx.se/download/curl-7.21.4.tar.gz;tar -xvf curl-7.21.4.tar.gz;)
      (cd /tmp/curl-7.21.4;./configure;make;make install;)
      EOH
    end
  end
end

case node['platform']
when "centos","amazon","fedora","ubuntu"
  if not File.exists?('/usr/local/lib/libicuio.so')
    bash "install icu4c" do
      user "root"
      cwd = "/tmp"
      code <<-EOH
      (cd /tmp;rm -rf /tmp/icu*;git clone git://github.com/membase/icu4c.git;)
      (cd /tmp/icu4c;cd source;./configure;make;make install;)
      EOH
    end
  end
end

case node['platform']
when "centos","amazon","fedora","ubuntu"
  bash "install pycrypto and paramiko" do
    user "root"
    cwd = "/tmp"
    code <<-EOH
    (cd /tmp;rm -rf pycrypto*;wget http://ftp.dlitz.net/pub/dlitz/crypto/pycrypto/pycrypto-2.3.tar.gz;)
    (cd /tmp;tar -xvf pycrypto-2.3.tar.gz;cd pycrypto-2.3;python2.6 setup.py build;python2.6 setup.py install;)
    (cd /tmp;rm -rf paramiko*;wget http://www.lag.net/paramiko/download/paramiko-1.7.4.tar.gz;tar -xvf paramiko-1.7.4.tar.gz;)
    (cd /tmp/paramiko-1.7.4;python2.6 setup.py build;python2.6 setup.py install;)
    EOH
  end
end
