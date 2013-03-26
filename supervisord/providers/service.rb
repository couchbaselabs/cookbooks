action :add_program do
	template "/etc/supervisor/conf.d/#{new_resource.name}" do
		source "supervisord.program.erb"
		cookbook "supervisord"
		owner "root"
		group "root"
		variables (	:name => "#{new_resource.name}",
			   	:command => "#{new_resource.command}", 
			   	:retries => "#{new_resource.retries}" )
	end

	execute "restart_supervisor" do
		command "/etc/init.d/supervisor stop ; /etc/init.d/supervisor start"
	end
end

action :add_fcgi_program do
	template "/etc/supervisor/conf.d/#{new_resource.name}" do
		source "supervisord.fcgi_program.erb"
		cookbook "supervisord"
		owner "root"
		group "root"
		variables (
			:name => "#{new_resource.name}",
			:command => "#{new_resource.command}",
			:retries => "#{new_resource.retries}",
			:socket => "#{new_resource.socket}",
			:owner => "#{new_resource.owner}",
			:environment => "#{new_resource.environment}",
			:user => "#{new_resource.user}",
			:socket_mode => "#{new_resource.socket_mode}",
			:process_number => "#{new_resource.process_number}" )
	end
	execute "restart_supervisor" do
		command "/etc/init.d/supervisor stop ; /etc/init.d/supervisor start"
	end
end
