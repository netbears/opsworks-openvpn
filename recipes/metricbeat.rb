# frozen_string_literal: true

directory "#{node['metricbeat']['conf_path']}/" do
  owner 'root'
  group 'root'
  recursive true
end

template "#{node['metricbeat']['conf_path']}/metricbeat.yml" do
  source 'metricbeat.yml.erb'
  owner 'root'
  group 'root'
  mode  '0640'
  action :create
end

remote_file '/tmp/metricbeat.deb' do
  source "https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-#{node['metricbeat']['version']}-amd64.deb"
  owner 'root'
  group 'root'
  mode '0755'
  backup false
end

execute 'extract_metricbeat' do
  command <<-BASH
    printf 'N\n' | dpkg -i /tmp/metricbeat.deb
    metricbeat setup
  BASH
end

service 'metricbeat' do
  action %i[enable restart]
end
