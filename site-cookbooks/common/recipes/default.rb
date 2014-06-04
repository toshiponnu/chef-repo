#
# Cookbook Name:: common
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute 'apt-get update'

%w{lv tree tmux}.each do |pkg|
    package pkg do
        action :install 
    end
end

execute 'locale-gen' do
  command 'locale-gen ja_JP.UTF-8'
  action :run
end

execute 'locales' do
  command 'dpkg-reconfigure locales'
  action :run
end

directory '/var/source' do 
    owner node['user']['username']
    group node['user']['username']
    mode '0755'
    action :create
end
