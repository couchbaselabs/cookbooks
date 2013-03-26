case node[:platform]
when "ubuntu","debian","redhat","centos","fedora"
  include_recipe "hostname::linux"
end
