# frozen_string_literal: true

execute 'apt-get update'

(node['base_packages'] + node['custom_packages']).each do |pkg|
  package pkg
end

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

template "#{node['openvpnas']['config_path']}/config.json" do
  source 'config.json.erb'
  owner 'root'
  group 'root'
  mode  '0644'
end

template "#{node['openvpnas']['config_script']}/import.py" do
  source 'import.py.erb'
  owner 'root'
  group 'root'
  mode  '0755'
end

execute 'import_vpn_settings' do
  command <<-BASH
    python3 #{node['openvpnas']['config_script']}/import.py
  BASH
  action :nothing
end
