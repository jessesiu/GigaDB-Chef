# GigaDB-Chef
Step1:
    Install Chef-Solo, and check version

Step2:
    Pull the chef-cook and site-cook to /etc/chef/

Step3:
    Copy the node.json file and solo.rb file, you may need change some parts in those files

Step4:
    cd /var/www/hosts/gigadb.cogini.com/htdocs
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
    
         pg_restore --host localhost --port 5432 --username "postgres" --dbname "gigadb_v3" --role "gigadb" --no-password               --verbose "gigadb_v3_0428.backup"
      
    
Step8:
    Make gigadb site enable. run the command.

    ln sites-available/gigadb sites-enabled/gigadb

Step9:
    Remove '/etc/nginx/conf.d/default.conf'. That's the "Welcome to nginx" site, which overshadows our site.
