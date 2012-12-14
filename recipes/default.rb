include_recipe "ark"

# Create user and group
#
group node.elasticsearch[:group] do
  action :create
end

user node.elasticsearch[:user] do
  comment  "ElasticSearch User"
  home     "#{node.elasticsearch[:dir]}/elasticsearch"
  shell    "/bin/bash"
  gid      node.elasticsearch[:group]
  supports :manage_home => false
  action   :create
end

# FIX: Work around the fact that Chef creates the directory even for `manage_home: false`
bash "remove the elasticsearch user home" do
  user    'root'
  code    "rm -rf  #{node.elasticsearch[:dir]}/elasticsearch"
  only_if "test -d #{node.elasticsearch[:dir]}/elasticsearch"
end

# Create ES directories
#
%w| conf_path data_path log_path pid_path |.each do |path|
  directory node.elasticsearch[path.to_sym] do
    owner     node.elasticsearch[:user]
    group     node.elasticsearch[:group]
    mode      0755
    recursive true
    action    :create
  end
end

# Download, extract, symlink the elasticsearch libraries and binaries
#
ark "elasticsearch" do
  url          node.elasticsearch[:download_url]
  version      node.elasticsearch[:version]
  checksum     node.elasticsearch[:checksum]
  owner        node.elasticsearch[:user]
  group        node.elasticsearch[:group]
  has_binaries ['bin/elasticsearch', 'bin/plugin']
end

# Create service
#
runit_service "elasticsearch"
