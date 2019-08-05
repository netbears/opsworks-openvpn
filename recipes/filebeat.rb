# frozen_string_literal: true

directory "#{node['filebeat']['conf_path']}/" do
  owner 'root'
  group 'root'
  recursive true
end

template "#{node['filebeat']['conf_path']}/filebeat.yml" do
  source 'filebeat.yml.erb'
  owner 'root'
  group 'root'
  mode  '0640'
  action :create
end

remote_file '/tmp/filebeat.deb' do
  source "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-#{node['filebeat']['version']}-amd64.deb"
  owner 'root'
  group 'root'
  mode '0755'
  backup false
end

execute 'extract_filebeat' do
  command <<-BASH
    printf 'N\n' | dpkg -i /tmp/filebeat.deb
  BASH
end

execute 'setup_filebeat' do
  command <<-BASH
    filebeat setup
  BASH
end

service 'filebeat' do
  action %i[enable restart]
end
