#
# Cookbook Name:: dynamodb
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "add-apt-repository" do
    action :install
end

execute "search java8" do
    command <<-EOF
            add-apt-repository ppa:webupd8team/java
            apt-get update
            echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
        EOF
    action :run
    not_if "apt-cache search oracle-java8-installer | grep oracle-java8-installer"
end

package "oracle-java8-installer" do
    action :install
end

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
    not_if { File.exists?("dynamodb_local_latest.tar.gz") }
end

execute "start dynamodb" do
    cwd "#{node['user']['home']}/dynamodb"
    command "java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar &"
    action :run
    not_if "pgrep dynamodb"
end

