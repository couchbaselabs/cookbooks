maintainer        "Couchbase Inc"
maintainer_email  "build@couchbase.com"
license           "Apache 2.0"
description       "Install packages and other configurations required for 
running 2.0 builds"
version           "1.0.0"
recipe            "builders-couchbase-2.0","Install packages and other configurations required for running 2.0 builds"

%w{ fedora redhat centos ubuntu debian }.each do |os|
  supports os
end
