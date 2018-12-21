include_recipe 'monit'

user = node['project']['user']
project_root = node['project']['root']
rvm = File.join('/', 'home', user, '.rvm', 'scripts', 'rvm')

monit_config 'puma' do
  source 'puma.conf.erb'
  variables(
    user: user,
    project_root: project_root,
    rvm: rvm
  )
end
