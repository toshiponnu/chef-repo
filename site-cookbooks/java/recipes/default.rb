#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{software-properties-common apt-file}.each do |pkg|
    package pkg do
        action :install 
    end
end

execute "prepare install java8" do
    command <<-EOF
            apt-file update
            add-apt-repository ppa:webupd8team/java
            apt-get update
            apt-get autoremove
            echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
        EOF
    action :run
    not_if "apt-cache search oracle-java8-installer | grep oracle-java8-installer"
end

package "oracle-java8-installer" do
    action :install
end
