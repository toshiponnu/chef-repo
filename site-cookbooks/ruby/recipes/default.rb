#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{build-essential curl zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev libmysqld-dev nodejs}.each do |pkg|
    package pkg do
        action :install 
    end
end

git "#{node['user']['home']}/.rbenv" do
    repository "git://github.com/sstephenson/rbenv.git"
    reference "master"
    action :sync
    user node['user']['username']
    group node['user']['username']
end

execute "install rbenv" do
    environment "HOME" => node['user']['home']
    command <<-EOF
            echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> #{node['user']['home']}/.zshrc
            echo 'eval "$(rbenv init -)"' >> #{node['user']['home']}/.zshrc
            exec $SHELL
        EOF
    action :run
    user node['user']['username']
    group node['user']['username']
    not_if "grep rbenv #{node['user']['home']}/.zshrc"
end

directory "#{node['user']['home']}/.rbenv/plugins" do 
    owner node['user']['username']
    group node['user']['username']
    mode '0755'
    action :create
end

git "#{node['user']['home']}/.rbenv/plugins/ruby-build" do
    repository "git://github.com/sstephenson/ruby-build.git"
    reference "master"
    action :sync
    user node['user']['username']
    group node['user']['username']
end

execute "install ruby" do
    environment "HOME" => node['user']['home']
    command <<-EOF
            #{node['user']['home']}/.rbenv/bin/rbenv install #{node['ruby']['version']}
            #{node['user']['home']}/.rbenv/bin/rbenv rehash
            #{node['user']['home']}/.rbenv/bin/rbenv global #{node['ruby']['version']}
        EOF
    action :run
    user node['user']['username']
    group node['user']['username']
    not_if { File.exists?("#{node['user']['home']}/.rbenv/versions/#{node['ruby']['version']}") }
end

template "#{node['user']['home']}/.gemrc" do 
    source "gemrc.erb" 
    owner node['user']['username']
    group node['user']['username']
    mode "0644"
end

execute "install rails" do
    environment "HOME" => node['user']['home']
    command <<-EOF
            #{node['user']['home']}/.rbenv/shims/gem update
            #{node['user']['home']}/.rbenv/shims/gem install bundler
            #{node['user']['home']}/.rbenv/shims/gem install rails --version="~> #{node['rails']['version']}"
            #{node['user']['home']}/.rbenv/bin/rbenv rehash
        EOF
    action :run
    user node['user']['username']
    group node['user']['username']
    not_if { File.exists?("#{node['user']['home']}/.rbenv/shims/rails") }
end

