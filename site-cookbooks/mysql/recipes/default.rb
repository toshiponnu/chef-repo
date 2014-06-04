#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "mysql-server" do
    action :install 
end

template "/etc/mysql/my.cnf" do
    source "my.cnf.erb"
    owner "root"
    group "root"
    mode "0644"
end

service "mysql" do
    supports :status => true, :restart => true, :reload => true 
    action [ :enable, :start ]
    not_if "pgrep mysql"
end
