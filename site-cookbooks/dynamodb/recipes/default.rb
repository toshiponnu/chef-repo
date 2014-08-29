#
# Cookbook Name:: dynamodb
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'java'

directory "#{node['user']['home']}/dynamodb" do 
    owner node['user']['username']
    group node['user']['username']
    mode '0755'
    action :create
end

execute "install dynamodb" do
    cwd "#{node['user']['home']}/dynamodb"
    command <<-EOF
            wget -O ./dynamodb_local_latest.tar.gz http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest
            tar zxvf dynamodb_local_latest.tar.gz
        EOF
    action :run
    user node['user']['username']
    group node['user']['username']
    not_if { File.exists?("#{node['user']['home']}/dynamodb/DynamoDBLocal.jar") }
end

execute "start dynamodb" do
    cwd "#{node['user']['home']}/dynamodb"
    command "java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar &"
    action :run
    user node['user']['username']
    group node['user']['username']
    not_if "pgrep -f DynamoDBLocal.jar"
end
