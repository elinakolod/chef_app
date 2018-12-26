user = node['project']['user']
group = node['project']['group']

package 'gnupg2' do
  action :install
end

execute 'add gpg2 key' do
  environment ({
    'HOME' => "/home/#{user}",
    'USER' => user
  })

  command 'sudo gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB'
end

# execute 'chown ~/.gnupg' do
#   command "chown -R #{user}:#{group} /home/#{user}/.gnupg"
#   user 'root'
# end
