#
# Cookbook Name:: users
# Recipe:: sysadmins
#
# Copyright 2009-2011, Opscode, Inc.
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

groups = {}

group_id = {'sysadmin' => 2300, 'engineering' => 2301, 'support' => 2303, 'etc' => 2304}

group_id.each do |g,m|
  group g do
    gid group_id[g]
    not_if { platform?('solaris2') }
  end
end

search(:users, '*:*') do |u|
  log "user: #{u}"
  log "user groups : #{u['groups']}"
end


search(:users, '*:*') do |u|

  # workaround since chef 0.10.6 on ubuntu converts u['groups'] to single element instead of array
  if u['groups'].kind_of?(Array)
    log "user: #{u}"
    log "user groups : #{u['groups']}"
    (u['groups'] || []).each do |group|
      (groups[group] ||= []) << u['id']
    end
  else
    group = u['groups']
    (groups[group] ||= []) << u['id']
  end

  if platform?('mac_os_x')
    home_dir = "/Users/#{u['id']}"
  else
    home_dir = "/home/#{u['id']}"
  end

  # fixes CHEF-1699
  ruby_block "reset group list" do
    block do
      Etc.endgrent
    end
    action :nothing
  end

  group u['id'] do
    gid u['uid']
  end


  user u['id'] do
    uid u['uid']
    gid u['gid'] || u['uid']
    shell u['shell']
    comment u['comment']
    home home_dir
    notifies :create, "ruby_block[reset group list]", :immediately
  end


  directory home_dir do
    owner u['id']
    group u['gid'] || u['id']
    mode "0755"
  end

  directory "#{home_dir}/.ssh" do
    owner u['id']
    group u['gid'] || u['id']
    mode "0700"
  end

  template "#{home_dir}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    owner u['id']
    group u['gid'] || u['id']
    mode "0600"
    variables :ssh_keys => u['ssh_keys']
    only_if { u['ssh_keys'] }
  end

  execute "chown" do
    command "chown -R #{u['id']} #{home_dir}"
    not_if { File.stat(home_dir).uid == u['uid'] }
  end
end

groups.each do |g, m|
  group g do
    if group_id[g]
      gid group_id[g]
    end
    members m
  end
end
