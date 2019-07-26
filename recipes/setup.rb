# frozen_string_literal: true

execute 'apt-get update'

remote_file "/tmp/openvpn-as-#{node['openvpnas']['version']}-#{node['openvpnas']['ubuntu_version']}.amd_64.deb" do
  source "http://swupdate.openvpn.org/as/openvpn-as-#{node['openvpnas']['version']}-#{node['openvpnas']['ubuntu_version']}.amd_64.deb"
  owner 'root'
  group 'root'
  mode '0664'
  action :create_if_missing
  notifies :run, 'execute[extract_openvpnas]', :immediately
end

execute 'extract_openvpnas' do
  command "dpkg -i /tmp/openvpn-as-#{node['openvpnas']['version']}-#{node['openvpnas']['ubuntu_version']}.amd_64.deb"
  cwd '/tmp/'
end

template '/tmp/openvpn_config.txt' do
  source 'config.txt.erb'
  owner 'root'
  group 'root'
  mode  '0755'
end

execute 'change_openvpn_loaddb' do
  command '/usr/local/openvpn_as/scripts/confdba -lf /tmp/openvpn_config.txt'
end

service 'openvpnas' do
  action :restart
end

execute 'change_openvpn_pass' do
  command "/usr/local/openvpn_as/scripts/ovpnpasswd -u openvpn -p #{node['openvpnas']['pass']}"
end
