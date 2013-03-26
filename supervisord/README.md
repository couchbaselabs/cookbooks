Description
===========
Supervisord Cookbook installs package, configures and provides a LWRP for supervisor

Attributes
========== 
```ruby
default["supervisord"]["logfile"]               = "/var/log/supervisor/supervisord.log"
default["supervisord"]["childlogdir"]           = "/var/log/supervisor"
default["supervisord"]["socket_mode"]           = "0700"
default["supervisord"]["include_dir"]           = "/etc/supervisor/conf.d/*.conf"
```

Usage
=====
Add the cookbook to your run list for your node and it will install to /usr/bin/supervisor
along with a configuration directory of /etc/supervisor/

LWRP
====
```ruby
actions :add_program, :add_fcgi_program


attribute :name, :name_attribute => true
attribute :command, :kind_of => String
attribute :retries, :kind_of => String
attribute :socket, :kind_of => String
attribute :owner, :kind_of => String
attribute :environment, :kind_of => String
attribute :user, :kind_of => String
attribute :socket_mode, :kind_of => String
attribute :process_number, :kind_of => String
```
:add_program only requires two variables command and retries

:add_fcgi_program requests all attributes (but does not require them like environment)

LWRP Example
============
```ruby
include_recipe "supervisord"

supervisord_service "challenger" do
        command "/usr/bin/challenger-fake-bin"
        retries "5"
        socket "/home/challenge/php.socket"
        owner "challenge:challenger"
        environment ""
        user "challenge"
        socket_mode "0775"
        process_number "12"
        action :add_fcgi_program
end
```
More
====

Thanks for taking the time to look at this summary. If you have any questions, comments
or input please feel free to contact me.
