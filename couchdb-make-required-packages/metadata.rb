maintainer       "Dustin Sallings"
maintainer	"Farshid Ghods"
maintainer_email "farshid.ghods@gmail.com"
license          "All rights reserved"
description "Installs packages required for building Apache COUCHDB"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

%w{ fedora redhat centos ubuntu debian }.each do |os|
  supports os
end
