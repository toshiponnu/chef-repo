#
# Cookbook Name:: memcached
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "memcached" do
    action :install
end

service "memcached" do
    supports :status => true, :restart => true, :reload => true 
    action [ :enable, :start ]
    not_if "pgrep memcached"
end
