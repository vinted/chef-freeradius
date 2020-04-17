#
# Cookbook Name:: freeradius
# Recipe:: default
#
# Copyright 2012, NM Consulting
#
# All rights reserved - Do Not Redistribute
#
include_recipe "freeradius::#{node['freeradius']['install_method']}"

if node['freeradius']['enable_ldap'] == true
  include_recipe 'freeradius::ldap'
end

template "#{node['freeradius']['dir']}/mods-available/sql" do
  source "sql.erb"
  owner node['freeradius']['user']
  group node['freeradius']['group']
  mode 0600
end

link '/etc/raddb/mods-enabled/sql' do
  to "#{node['freeradius']['dir']}/mods-available/sql"
  link_type :symbolic
  only_if { node['platform_version'].to_f >= 7 }
end

template "#{node['freeradius']['dir']}/clients.conf" do
  source "clients.conf.erb"
  owner node['freeradius']['user']
  group node['freeradius']['group']
  mode 0600
end

service node['freeradius']['service'] do
  supports :restart => true, :status => false, :reload => false
  action :enable
end
