remote_file File.join(Chef::Config[:file_cache_path],
                      node['sync_gateway']['package_file']) do
  source node['sync_gateway']['package_full_url']
  action :create_if_missing
end

case node['platform']
when 'windows'
    include_recipe 'sync-gateway::_windows'
when *%w(debian ubuntu)
    include_recipe 'sync-gateway::_linux'
end

directory ::File.dirname(node['sync_gateway']['logFilePath']) do
    recursive true
    owner 'sync_gateway' unless node['platform'] == 'windows'
end

template node['sync_gateway']['config_path'] do
    source 'config.json.erb'
    action :create
    notifies :restart, "service[#{node['sync_gateway']['service_name']}]"
    owner 'sync_gateway' unless node['platform'] == 'windows'
end

service "#{node['sync_gateway']['service_name']}" do
    action [:enable, :start]
end

