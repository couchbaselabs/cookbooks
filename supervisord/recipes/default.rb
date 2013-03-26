#
# Cookbook Name:: supervisord
# Recipe:: default
# Author: Brett Gailey <brett.gailey@dreamhost.com>
# Copyright 2012, DreamHost.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "supervisor" do
	action [:upgrade]
end

template "/etc/supervisor/supervisord.conf" do
	source "supervisord.conf.erb"
	owner "root"
	group "root"
end


service "supervisord" do
	supports :restart => true
	pattern "supervisor"
	action[:enable, :restart] # Bug in supervisor init script prevents :restart from being used (debian only I think)
end
