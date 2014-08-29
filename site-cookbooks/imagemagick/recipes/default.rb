#
# Cookbook Name:: imagemagick
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{imagemagick libmagickwand-dev}.each do |pkg|
    package pkg do
        action :install
    end
end
