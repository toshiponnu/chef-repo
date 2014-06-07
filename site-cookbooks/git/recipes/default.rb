#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "git" do 
    action :install 
end 

template "#{node['user']['home']}/.gitconfig" do
    source "gitconfig.erb"
    owner node['user']['username']
    group node['user']['username']
    mode "0644"
end
