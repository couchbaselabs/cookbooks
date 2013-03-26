machine = node['kernel']['machine']
tmpdir = '/var/tmp/chef'

directory tmpdir do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

case node['platform']
when "ubuntu","debian"
  %w{git-core libicu-dev libcurl4-openssl-dev libsasl2-dev pkg-config fakeroot
     debhelper python-dev emacs23-nox}.each do |pkg|
    package pkg do
      action :install
    end
  end

  package 'libevent-dev' do
    action :remove
  end

  node['packages']['dev'].each do |pkg, version|
    vpkg = "#{pkg}-#{version}"
    remote_file "/#{tmpdir}/#{vpkg}-#{machine}.deb" do
      source "http://downloads.northscale.com/builddeps/#{vpkg}-#{machine}.deb"
      action :create_if_missing
    end
    dpkg_package pkg do
      source "/#{tmpdir}/#{vpkg}-#{machine}.deb"
      action :install
    end
  end

  # I don't know how they broke this, but it was broken on some
  # version of ubuntu.
  directory "/usr/local/lib/python2.6/dist-packages/" do
    recursive true
  end

when "centos","redhat","fedora"
#  %w{git cyrus-sasl-devel emacs-nox python-devel openssl-devel google-perftools-devel jemalloc-devel}.each do |pkg|
  %w{git cyrus-sasl-devel python-devel openssl-devel google-perftools-devel jemalloc-devel}.each do |pkg|
    package pkg do
      action :install
    end
  end

  package 'libevent-devel' do
    action :remove
  end

  node['packages']['dev'].each do |pkg, version|
    vpkg = "#{pkg}-#{version}"
    url = "http://downloads.northscale.com/builddeps/#{vpkg}-#{machine}.rpm"
    localfile = "/#{tmpdir}/#{vpkg}-#{machine}.rpm"

    remote_file localfile do
      source url
      action :create_if_missing
    end

    rpm_package pkg do
      source localfile
      action :install
    end
  end

end

if node['platform'] == 'fedora' then
  %w{systemtap systemtap-sdt-devel ncurses-devel kernel-devel erlang}.each do |pkg|
    package pkg do
      action :install
    end
  end
end

if node['platform'] == 'amazon' then

 ERLV = 'R14B04'

  execute "download Erlang/OTP" do
    not_if "test -f /tmp/otp_src_#{ERLV}.tar.gz"
    command "wget http://www.erlang.org/download/otp_src_#{ERLV}.tar.gz -O /tmp/otp_src_#{ERLV}.tar.gz"
  end

  execute "unpack Erlang/OTP" do
    not_if "test -d /tmp/otp_src_#{ERLV}"
    command "tar xzf /tmp/otp_src_#{ERLV}.tar.gz -C /tmp"
  end

  unless `uname`.strip == 'Darwin'
    package "build-essential"
    package "libncurses5-dev openssl libssl-dev libsctp-dev libexpat1-dev"
  end

  script "build Erlang/OTP" do
    interpreter "bash"
    cwd "/tmp/otp_src_#{ERLV}"
    code <<-SH
    ./configure --enable-threads --enable-smp-support --enable-kernel-poll --enable-hipe --enable-sctp {"--with-ssl=/usr/lib/ssl/" unless `uname`.strip == 'Darwin'}
    make install
    SH
  end

end

# Common
#%w{autoconf automake libtool python-setuptools ccache}.each do |pkg|
%w{autoconf automake libtool python-setuptools}.each do |pkg|
  package pkg do
    action :install
  end
end

easy_install_package 'pip'
easy_install_package 'paramiko'

cookbook_file "/usr/bin/repo" do
  owner 0
  group 0
  mode "0755"
end
