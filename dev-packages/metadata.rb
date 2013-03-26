maintainer       "Dustin Sallings"
maintainer_email "dustin@couchbase.com"
license          "All rights reserved"
description      "Installs/Configures dev-packages"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

%w{ fedora redhat centos ubuntu debian }.each do |os|
  supports os
end
