case platform 
when "ubuntu","debian"
  default[:ntp][:service] = "ntp"
when "redhat","centos","fedora"
  default[:ntp][:service] = "ntpd"
end

default[:ntp][:is_server] = false
default[:ntp][:servers]   = %w(corp-fs1.hq.northscale.net qa-fs2.hq.northscale.net)
