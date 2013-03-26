package "autofs"

service "autofs" do
  supports [ :start, :stop, :restart, :reload, :status ]
  action [ :enable, :start ]
end

template "/etc/auto.master" do
  source "auto.master.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :reload, resources(:service => "autofs"), :immediately
end

node[:autofs][:maps].each do |map, args|
  log "autofs args"
  log "#{map}:  #{args.inspect}"
  template args[:source].gsub(/file:/, '') do
    owner "root"
    group "root"
    mode 0644
    source "auto.map.erb"
    variables(:keys => args[:keys])
    notifies :reload, resources(:service => "autofs"), :immediately
  end
end
