#
# Cookbook Name:: php5
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "php5" do
    action :install
end

%w{php5-common php-apc php5-curl php5-mcrypt php5-mysql php5-memcached php-pear smarty3}.each do |pkg|
    package pkg do
        action :install
    end
end

template "/etc/php5/apache2/php.ini" do
    source "php.ini.erb"
    owner "root"
    group "root"
    mode "0644"
end

file "/var/log/php.log" do
  owner "root"
  group "root"
  mode "0666"
  action :create
end
