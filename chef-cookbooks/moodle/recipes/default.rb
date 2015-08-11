#
# Cookbook Name:: moodle
# Recipe:: default
#
# Copyright 2012, Cogini
#

include_recipe 'git'
include_recipe 'php::module_curl'
include_recipe 'php::module_dom'
include_recipe 'php::module_gd'
include_recipe 'php::module_intl'
include_recipe 'php::module_mbstring'
include_recipe 'php::module_soap'
include_recipe 'php::module_xmlrpc'
include_recipe 'basics::cronic'


site_dir = node.moodle.site_dir
data_dir = node.moodle.data_dir
moodle_user = node.moodle.user
moodle_group = node.moodle.group


[site_dir, data_dir].each do |dir|
    directory dir do
        action :create
        recursive true
        group moodle_group
    end
end

git site_dir do
    repository "git://git.moodle.org/moodle.git"
    reference node[:moodle][:branch]
end

execute "Change owner of #{data_dir}" do
    command "chown -R #{moodle_user}:#{moodle_group} #{data_dir}"
end


cron 'moodle maintenance cron' do
    hour node[:moodle][:cron_time]
    minute 0
    command "#{node[:cronic]} php #{site_dir}/admin/cli/cron.php"
end
