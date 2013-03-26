template "/etc/auto_master" do
  source "auto.master.erb"
  owner "root"
  group "wheel"
  mode "0644"
  notifies :run, "execute[restart_autofs]"
end

template "/etc/auto_home" do
  owner "root"
  group "wheel"
  mode 0644
  source "auto.map.erb"
  variables(:keys => node[:autofs][:maps]["/nethome"][:keys])
  notifies :run, "execute[restart_autofs]"
end

execute "restart_autofs" do
  command "killall autofsd automountd"
  action :nothing
end
