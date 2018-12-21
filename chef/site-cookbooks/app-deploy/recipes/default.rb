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
