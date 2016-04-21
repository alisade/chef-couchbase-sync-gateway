include_recipe 'nssm'

windows_package 'Couchbase Sync Gateway' do
    source File.join(Chef::Config[:file_cache_path], node['sync_gateway']['package_file'])
    options "/s /v\"/qn AgreeToLicense=Yes INSTALLDIR=\\\"#{node['sync_gateway']['install_dir'].gsub('/','\\\\')}\\\"\""
    installer_type :custom
    action :install
end

nssm "#{node['sync_gateway']['service_name']}" do
    program "#{node['sync_gateway']['install_dir']}\\sync_gateway.exe"
    args 'config.json'
    params(
        Start: 'SERVICE_DELAYED_AUTO_START'
    )
    start false
    action :install
    notifies :restart, "service[#{node['sync_gateway']['service_name']}]"
end
