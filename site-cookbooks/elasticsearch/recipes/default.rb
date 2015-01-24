#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'java'

execute "install elasticsearch" do
    cwd "#{node['user']['home']}"
    command <<-EOF
            wget -O ./elasticsearch.deb https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-#{node['elasticsearch']['version']}.deb 
            sudo dpkg --purge elasticsearch
            sudo dpkg -i elasticsearch.deb
        EOF
    action :run
    user node['user']['username']
    group node['user']['username']
    notifies :restart, "service[elasticsearch]"
    not_if "dpkg -l | grep elasticsearch | grep #{node['elasticsearch']['version']}"
end

template "/etc/elasticsearch/elasticsearch.yml" do
    source "elasticsearch.yml.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, "service[elasticsearch]"
end

execute "install kuromoji plugin" do
    command <<-EOF
            sudo /usr/share/elasticsearch/bin/plugin -remove elasticsearch/elasticsearch-analysis-kuromoji
            sudo /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-kuromoji/#{node['elasticsearch']['kuromoji_version']}
        EOF
    action :run
    notifies :restart, "service[elasticsearch]"
    not_if { File.exists?("/usr/share/elasticsearch/plugins/analysis-kuromoji/elasticsearch-analysis-kuromoji-#{node['elasticsearch']['kuromoji_version']}.jar") }
end

execute "install elasticsearch-HQ plugin" do
    command "sudo /usr/share/elasticsearch/bin/plugin -install royrusso/elasticsearch-HQ"
    action :run
    notifies :restart, "service[elasticsearch]"
    not_if { File.exists?("/usr/share/elasticsearch/plugins/HQ/_site/index.html") }
end

service "elasticsearch" do
    supports :status => true, :restart => true
    action [ :enable, :start ]
end
