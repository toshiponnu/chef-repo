#
# Cookbook Name:: zsh
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "zsh" do
    action :install 
end

user node['user']['username'] do
    shell "/bin/zsh"
    action :manage
end

template "#{node['user']['home']}/.zshrc" do
    source "zshrc.erb"
    owner node['user']['username']
    group node['user']['username']
    mode "0644"
end
