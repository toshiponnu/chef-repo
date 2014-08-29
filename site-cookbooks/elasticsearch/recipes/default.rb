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
            wget -O ./elasticsearch.deb https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb
            sudo dpkg -i elasticsearch.deb
        EOF
    action :run
    user node['user']['username']
    group node['user']['username']
    not_if "dpkg -l | grep elasticsearch"
end

template "/etc/elasticsearch/elasticsearch.yml" do
    source "elasticsearch.yml.erb"
    owner "root"
    group "root"
    mode "0644"
end

execute "install kuromoji plugin" do
    command "sudo /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-kuromoji/2.2.0"
    action :run
    not_if { File.exists?("/usr/share/elasticsearch/plugins/analysis-kuromoji/elasticsearch-analysis-kuromoji-2.2.0.jar") }
end

execute "install elasticsearch-HQ plugin" do
    command "sudo /usr/share/elasticsearch/bin/plugin -install royrusso/elasticsearch-HQ"
    action :run
    not_if { File.exists?("/usr/share/elasticsearch/plugins/HQ/_site/index.html") }
end

service "elasticsearch" do
    supports :status => true, :restart => true, :reload => true 
    action [ :enable, :start ]
    not_if "pgrep elasticsearch"
end
