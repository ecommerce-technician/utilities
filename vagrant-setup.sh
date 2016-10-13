#!bin/bash
cd ~/Downloads
wget http://download.virtualbox.org/virtualbox/4.1.44/virtualbox-4.1_4.1.44-104071~Ubuntu~hardy_amd64.deb
sudo dpkg -i virtualbox-4.1_4.1.44-104071-Ubuntu-hardy_amd64.deb
vagrant init bingmann/ubuntu-8.04.4-i386; vagrant up --provider virtualbox


