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
