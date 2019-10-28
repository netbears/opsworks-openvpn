# frozen_string_literal: true

execute 'apt-get update'

(node['base_packages'] + node['custom_packages']).each do |pkg|
  package pkg
end

execute 'wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | apt-key add -'

file '/etc/apt/sources.list.d/openvpn-as-repo.list' do
  content 'deb http://as-repository.openvpn.net/as/debian bionic main'
end

execute 'apt-get update'

package 'openvpn-as' do
  version node['openvpnas']['version']
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

service 'openvpnas' do
  action :restart
end

execute 'import_vpn_settings' do
  command <<-BASH
    python3 #{node['openvpnas']['config_script']}/import.py
  BASH
end

include_recipe 'openvpn_stack::node_exporter'
include_recipe 'openvpn_stack::logrotate'
include_recipe 'openvpn_stack::filebeat' if node['filebeat']['enabled'] == 'true'
include_recipe 'openvpn_stack::metricbeat' if node['metricbeat']['enabled'] == 'true'
include_recipe 'ntp::default'
