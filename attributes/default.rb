default['sync_gateway']['edition'] = "community"
default['sync_gateway']['version'] = "1.1.0"
default['sync_gateway']['build'] = "28"

case node['platform']
when "windows"
    default['sync_gateway']['package_file'] = "couchbase-sync-gateway-#{node['sync_gateway']['edition']}_#{node['sync_gateway']['version']}-#{node['sync_gateway']['build']}_x86_64.exe"
else
    Chef::Log.error("Couchbase Sync Gateway is not supported on #{node['platform_family']}")
end

default['sync_gateway']['package_base_url'] = "http://packages.couchbase.com/releases/couchbase-sync-gateway/#{default['sync_gateway']['version']}"
default['sync_gateway']['package_full_url'] = "#{node['sync_gateway']['package_base_url']}/#{default['sync_gateway']['package_file']}"

case node['platform_family']
when "windows"
  default['sync_gateway']['install_dir'] = 'C:\Program Files (x86)\CouchbaseSyncGateway'
else
  default['sync_gateway']['install_dir'] = "/opt/couchbase-sync-gateway"
end

default['sync_gateway']['service_name'] = 'CouchbaseSyncGateway'

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

