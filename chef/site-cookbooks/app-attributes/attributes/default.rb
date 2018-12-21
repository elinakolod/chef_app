# Project -------------------------------------------------------

override['project']['name'] = 'chef_app'
override['project']['repository'] = 'git@github.com:elinakolod/chef_app.git'

# Locale ---------------------------------------------------------

override['locale']['lang'] = 'en_US.UTF-8'
override['locale']['lc_all'] = node['locale']['lang']

# Postgresql -----------------------------------------------------

override['postgresql']['version'] = '9.6'
override['postgresql']['users'] = [{
  'name' => 'deployer',
  'encrypted_password' => 'md5ff74e976a4bc9e04160534427b3af341',
  'superuser' => true
}, {
  'name' => node['project']['name'],
  'encrypted_password' => 'md5ff74e976a4bc9e04160534427b3af341',
  'superuser' => false # the user of the project's database must have access only to the project database
}]

override['postgresql']['databases'] = [{
  'name' => "#{node['project']['name']}_#{node['environment']}",
  'owner' => node['project']['name']
}]
