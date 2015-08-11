name             "basics"
maintainer       "Cogini"
maintainer_email "phu@cogini.com"
license          "All rights reserved"
description      "Installs/Configures basics"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
depends          "apt"
depends          "autoupdate"
depends          "gdebi"
depends          "localbackup"
depends          "postfix"
depends          "ssh"
depends          "sysctl"
depends          "timezone"
depends          "user"
depends          "yum"
