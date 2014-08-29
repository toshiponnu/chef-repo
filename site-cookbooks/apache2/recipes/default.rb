#
# Cookbook Name:: apache2
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{apache2 apache2-mpm-prefork}.each do |pkg|
    package pkg do
        action :install 
    end
end

package "libapache2-mod-php5" do
    action :install 
end

template "/etc/apache2/apache2.conf" do
    source "apache2.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :reload, "service[apache2]"
end

template "/etc/apache2/conf-available/security.conf" do
    source "security.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :reload, "service[apache2]"
end

template "/etc/apache2/sites-available/app.conf" do
    source "app.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :reload, "service[apache2]"
end

link "/etc/apache2/sites-enabled/app.conf" do
    to "/etc/apache2/sites-available/app.conf"
end

service "apache2" do 
    supports :status => true, :restart => true, :reload => true 
    action [ :enable, :start ]
end
