group "staff" do
end


known_users = data_bag('users')

blacklist_users = %w(rod rob joe patg eric joon otrond ltrond sean trond.old)
whitelist_users = %w(git buildbot communitybb avahi-autoipd nfsnobody nobody)

node[:etc][:passwd].each do |username, entry|
  known_user = known_users.index(username) && data_bag_item('users', username)
  unless known_user || whitelist_users.index(username) || entry[:uid] < 500
    log "UNMANAGED USER:  #{username} (#{entry[:uid]})"
  end

  # Migrate other user accounts.
  if known_user && ( entry[:uid] != known_user['uid'] )
    log "Migrating #{username} from #{entry[:uid]} -> #{known_user['uid']}"
    user username do
      uid known_user['uid']
      action :modify
    end
  end

  if blacklist_users.index(username)
    user username do
      action :remove
    end
  end

end

# do not delete files under home directory of a user that is removed
#blacklist_users.map{|u| "/home/#{u}"}.select{|f|File.exists? f}.each do |f|
#  directory f do
#    action :delete
#    recursive true
#  end
#end

include_recipe "users::all"
