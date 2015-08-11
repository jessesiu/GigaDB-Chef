#This should be the default, but until then this will do.
ssl_verify_mode :verify_peer

chef_dir = File.expand_path(File.dirname(__FILE__))
cookbook_path [
    "/etc/chef/chef-cookbooks",
    "/etc/chef/site-cookbooks",
]
role_path "/etc/chef/chef-repo/roles"
