# This should be the default, but until then this will do.
ssl_verify_mode :verify_peer

chef_dir = File.expand_path(File.dirname(__FILE__))
cookbook_path [
    "#{chef_dir}/chef-cookbooks",
    "#{chef_dir}/site-cookbooks",
]
role_path "#{chef_dir}/chef-repo/roles"
