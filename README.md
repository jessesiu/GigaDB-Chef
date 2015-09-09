# GigaDB-Chef
Step1:
    Install Chef-Solo, and check version

Step2:
    Pull the chef-cook and site-cook to /etc/chef/

Step3:
    Copy the node.json file and solo.rb file, you may need change some parts in those files

Step4:
    cd /var/www/hosts/localhost/htdocs
    Go to the https://github.com/jessesiu/GigaDBV3 repo, pull the website code from gigadb-website.git_2 folder

    $ sudo -u gigadb git pull  #pull website code. make sure you're on master first, of course.

Step5:
    run the command

    sudo chef-solo -c /etc/chef/solo.rb -j /etc/chef/node.json -o 'gigadb::default'

    or

    sudo chef-solo -c /etc/chef/solo.rb -j /etc/chef/node.json -o 'role[server],gigadb::default'

Step6:
    check postgresql cookbook directory
    Must specify postgresql directory (default dir value in postgresql cookbook is var/lib/pgsql/data, which is wrong):

    "postgresql": {
        "version": "9.1",
        "dir": "/var/lib/pgsql/9.1/data"
    }

Step7:
    Go to the https://github.com/jessesiu/GigaDBV3 repo, pull the database backup file gigadb_v3_0717.backup.
    Using pg_restore restore gigadb_v3 database from backup file.
    
    
    Command:
        
         su - postgres
    
         pg_restore -d gigadb_v3 gigadb_v3_0717.backup
      
    
Step8:
    Make gigadb site enable. run the command.

    ln sites-available/gigadb sites-enabled/gigadb

Step9:
    Remove '/etc/nginx/conf.d/default.conf'. That's the "Welcome to nginx" site, which overshadows our site.


Step10:
    Disable SELinux 

Step11:

    Check following things:

    is pgsql data folder owned by postgres?

    is var/www folders readable (755?)

    is IPTABLES 'rejecting all' on input? check INPUT number 5 using command: iptables -L 
    
Step12:

Set the Ftp service:

    pasv_enable=Yes
    pasv_max_port=10100
    pasv_min_port=10090
    
This enables passive mode and restricts it to using the ten ports for data connections. This is useful as you need to open these ports on your firewall.

    iptables -I INPUT -p tcp --destination-port 10090:10100 -j ACCEPT
    
If after testing this all works then save the state of your firewall with

    service iptables save
    

