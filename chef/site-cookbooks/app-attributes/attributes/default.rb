# Project -------------------------------------------------------

override['project']['name'] = 'chef-app'
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

# Ruby -----------------------------------------------------------

override['ruby']['versions'] = ['2.5.3']
override['ruby']['default'] = '2.5.3'

# Node.js --------------------------------------------------------

override['nodejs']['version'] = '9.3.0'
override['nodejs']['binary']['checksum'] = 'b7338f2b1588264c9591fef08246d72ceed664eb18f2556692b4679302bbe2a5'

# Nginx -----------------------------------------------------------

override['nginx']['source']['version'] = '1.13.7'
override['nginx']['source']['checksum'] = 'beb732bc7da80948c43fd0bf94940a21a21b1c1ddfba0bd99a4b88e026220f5c'

# Monit -----------------------------------------------------------

override['monit']['username'] = 'USERNAME'
override['monit']['password'] = 'PASSWORD'
