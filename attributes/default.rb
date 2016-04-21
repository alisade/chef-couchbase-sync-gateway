default['sync_gateway']['edition'] = "community"
default['sync_gateway']['version'] = "1.2.0"
default['sync_gateway']['build'] = "79"

case node['platform']
when "windows"
    default['sync_gateway']['build'] = '83b'
    default['sync_gateway']['package_file'] = "couchbase-sync-gateway-#{node['sync_gateway']['edition']}_#{node['sync_gateway']['version']}-#{node['sync_gateway']['build']}_x86_64.exe"
    default['sync_gateway']['service_name'] = 'CouchbaseSyncGateway'
when *%w(debian ubuntu)
    default['sync_gateway']['package_file'] = "couchbase-sync-gateway-#{node['sync_gateway']['edition']}_#{node['sync_gateway']['version']}-#{node['sync_gateway']['build']}_x86_64.deb"
    default['sync_gateway']['service_name'] = 'sync_gateway'
else
    Chef::Log.error("Couchbase Sync Gateway is not supported on #{node['platform_family']}")
end
Chef::Log.warn node['sync_gateway']['package_file']
Chef::Log.warn '>>>>>>>>>>>>>>>>>>>>>>>'
Chef::Log.warn node['platform']

default['sync_gateway']['package_base_url'] = "http://packages.couchbase.com/releases/couchbase-sync-gateway/#{default['sync_gateway']['version']}"
default['sync_gateway']['package_full_url'] = "#{node['sync_gateway']['package_base_url']}/#{default['sync_gateway']['package_file']}"

case node['platform_family']
when "windows"
  default['sync_gateway']['install_dir'] = 'C:\Program Files (x86)\CouchbaseSyncGateway'
  default['sync_gateway']['config_path'] = "#{node['sync_gateway']['install_dir']}/config.json"
else
  default['sync_gateway']['install_dir'] = "/opt/couchbase-sync-gateway"
  default['sync_gateway']['config_path'] = "/home/sync_gateway/sync_gateway.json"
end

default['sync_gateway']['adminInterface'] = '127.0.0.1:4985'
default['sync_gateway']['adminUI'] = '127.0.0.1:4985/_admin/'
default['sync_gateway']['compressResponses'] = true
default['sync_gateway']['interface'] = ':4984'
default['sync_gateway']['log'] = ['HTTP', 'Auth', 'Access', 'Shadow']
default['sync_gateway']['logFilePath'] = 'stderr'
default['sync_gateway']['maxCouchbaseChttponnections'] = 16
default['sync_gateway']['maxFileDescriptors'] = 5000
default['sync_gateway']['pretty'] = false
default['sync_gateway']['slowServerCallWarningThreshold'] = 200

