#!bin/bash
echo "make sure you copy and pasted node-v4.3.1.tar.gz from alexScripts to Downloads dir"
apt-get install make g++ libssl-dev git
echo "installing node"
cd ~/Downloads
tar -xvf node-v4.4.1.tar.gz
mv node-v4.4.1 /tmp
cd /tmp/node-v4.4.1
./configure
make
make install
echo "node installed"
node -v
