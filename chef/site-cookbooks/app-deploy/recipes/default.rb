encrypted_data = Chef::EncryptedDataBagItem.load('configs', node.environment)

config = node['project']

deployer = config['user']
deployer_group = config['group']

root_path = config['root']
home_path = File.join('/', 'home', deployer)
shared_path = File.join(root_path, 'shared')
bundle_path = File.join(shared_path, 'vendor', 'bundle')
config_path = File.join(shared_path, 'config')
ssh_path = File.join(shared_path, '.ssh')

puma_state_file = File.join(shared_path, 'tmp', 'pids', 'puma.state')
sidekiq_state_file = File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid')
maintenance_file = File.join(shared_path, 'tmp', 'maintenance')


# SSH -------------------------------------------------------------------------------------------------

ssh_key_file = File.join(ssh_path, deployer)
ssh_wrapper_file = File.join(ssh_path, 'wrap-ssh4git.sh')

directory ssh_path do
  owner deployer
  group deployer_group
  recursive true
end

cookbook_file ssh_key_file do
  source 'key'
  owner deployer
  group deployer_group
  mode 0o600
end

file ssh_wrapper_file do
  content "#!/bin/bash\n/usr/bin/env ssh -o \"StrictHostKeyChecking=no\" -i \"#{ssh_key_file}\" $1 $2"
  owner deployer
  group deployer_group
  mode 0o755
end

# DIRECTORIES ---------------------------------------------------------------------------------------------------------

%w[config log public/system public/uploads public/assets repo tmp/cache tmp/pids tmp/sockets].each do |dir|
  directory File.join(shared_path, dir) do
    owner deployer
    group deployer_group
    mode 0o755
    recursive true
  end
end

# DB ---------------------------------------------------------------------------------------------------------

template File.join(config_path, 'database.yml') do
  source File.join(node.environment, 'database.yml.erb')
  variables(
    environment: node.environment,
    database: encrypted_data['database']['name'],
    user: encrypted_data['database']['user'],
    password: encrypted_data['database']['password']
  )
  sensitive true
  owner deployer
  group deployer_group
  mode 0o644
end

# Application ---------------------------------------------------------------------------------------------------------

file File.join(config_path, 'application.yml') do
  content Hash[node.environment, encrypted_data['application']].to_yaml
  sensitive true
  owner deployer
  group deployer_group
  mode 0o644
end
