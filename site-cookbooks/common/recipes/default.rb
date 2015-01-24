#
# Cookbook Name:: common
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute 'apt-get update'

execute 'locale-gen' do
    command <<-EOF
            locale-gen ja_JP.UTF-8
            dpkg-reconfigure locales
        EOF
    action :run
    not_if "echo $LANG | grep 'ja_JP.UTF-8'"
end

%w{lv tree tmux ntp}.each do |pkg|
    package pkg do
        action :install 
    end
end

template "/etc/ntp.conf" do
    source "ntp.conf.erb"
    owner "root"
    group "root"
    mode 0644
end

service "ntp" do
    supports status: true, restart: true, reload: true
    action [ :enable, :start ]
end

directory '/var/source' do 
    owner node['user']['username']
    group node['user']['username']
    mode '0755'
    action :create
end
