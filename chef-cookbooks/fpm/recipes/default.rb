#
# Cookbook Name:: fpm
# Recipe:: default
#
# Copyright 2012, Cogini
#

include_recipe "build-essential"

node[:fpm][:dependencies].each do |pkg|
    package pkg do
        action :install
    end
end

gem_package "fpm" do
    action :install
end
