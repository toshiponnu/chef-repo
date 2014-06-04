#
# Cookbook Name:: composer
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "install composer" do 
    cwd node['user']['home']
    command "curl -sS https://getcomposer.org/installer | php"
    creates node['user']['home']'/composer.phar'
end

execute "mv composer" do 
    cwd node['user']['home']
    command "cp composer.phar /usr/bin/composer"
    creates '/usr/bin/composer'
end
