machine = node['kernel']['machine']

case node['platform']
when "ubuntu","debian"
  %w{git-core automake xulrunner-dev autoconf subversion-tools libtool help2man build-essential erlang erlang-manpages wget libicu-dev libreadline5-dev checkinstall openjdk-6-jdk}.each do |pkg|
    package pkg do
      action :install
    end
  end
end
