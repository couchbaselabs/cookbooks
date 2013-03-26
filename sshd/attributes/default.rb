case platform
when "ubuntu", "debian"
  default[:ssh][:service] = "ssh"
when "redhat", "centos", "fedora"
  default[:ssh][:service] = "sshd"
when "mac_os_x"
  default[:ssh][:service] = "com.openssh.sshd"
end
