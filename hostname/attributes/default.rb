default[:hostinfo][:domain] = "hq.northscale.net"
default[:hostinfo][:name] = "#{node.name}.#{node[:hostinfo][:domain]}"
