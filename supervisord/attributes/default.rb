# Default attributes for supervisord template

default["supervisord"]["logfile"] 		= "/var/log/supervisor/supervisord.log"
default["supervisord"]["childlogdir"]  		= "/var/log/supervisor"
default["supervisord"]["socket_mode"] 		= "0700"
default["supervisord"]["include_dir"] 		= "/etc/supervisor/conf.d/*.conf"
