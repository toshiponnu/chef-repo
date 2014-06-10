#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{vim exuberant-ctags}.each do |pkg|
    package pkg do
        action :install
    end
end

directory "#{node['user']['home']}/.vim" do 
    owner node['user']['username']
    group node['user']['username']
    mode '0755'
    action :create
end

directory "#{node['user']['home']}/.vim/bundle" do 
    owner node['user']['username']
    group node['user']['username']
    mode '0755'
    action :create
end

git "#{node['user']['home']}/.vim/bundle/neobundle.vim" do
    repository "git://github.com/Shougo/neobundle.vim"
    reference "master"
    action :sync
    user node['user']['username']
    group node['user']['username']
end

template "#{node['user']['home']}/.vimrc" do
    source "vimrc.erb"
    owner node['user']['username']
    group node['user']['username']
    mode "0644"
end
