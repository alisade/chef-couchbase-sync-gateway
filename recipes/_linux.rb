dpkg_package 'Sync gateway' do
    source File.join(Chef::Config[:file_cache_path],
                     node['sync_gateway']['package_file'])
end
