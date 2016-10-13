#!/bin/bash
echo 'make a strong password like 4XqWj?@D_Qh5UO$M'
adduser ${USER}
passwd ${PASSWORD}
su - ${USER}
exit
sudo sed -i -e 's/# User privilege specification/\'$'\${USER}\tALL=(ALL:ALL) ALL/g' /etc/sudoers
su - ${USER}
sudo apt-get install build-essential
echo '===================================================='
echo '====if sudo didnt work type "exit && visudo" and modify your sudoers user'
echo '===================================================='
sudo apt-get update
cd ~
echo '=====Check https://nodejs.org/en/download/ for updates > v4.4.3'
wget https://nodejs.org/dist/v4.4.3/node-v4.4.3.tar.gz
mkdir node
tar xvf node-v*.tar.?z --strip-components=1 -C node
cd ~
rm -rf node-v*
mkdir node/etc
echo 'prefix=/usr/local' > node/etc/npmrc
echo '======Installing node binaries to installation dir'
sudo mv node /opt/
echo '======Giving root ownership of node files'
sudo chown -R root: /opt/node
echo '======Removing existing node & npm symlinks'
sudo rm -rf /usr/local/bin/node
sudo rm -rf /usr/local/bin/npm
echo '======Creating new nod & npm symlinks'
sudo ln -s /opt/node/bin/node /usr/local/bin/node
sudo ln -s /opt/node/bin/npm /usr/local/bin/npm
echo '=====At this point create your node app, etc'
cd ~
mkdir bundleslang
cd bundleslang
echo "var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Welcome\n');
}).listen(7777, '${IP}');
console.log('Server running at http://${IP}/:7777/');" > bundleslang.js
echo '======= App has been created'
cat bundleslang.js
node bundleslang.js
curl http://{IP}/:7777/
echo '\n======== Installing PM2'
sudo npm install pm2 -g
echo '======== Adding application to PM2'
pm2 start bundleslang.js
echo '======== Setting PM2 to startup on boot'
sudo pm2 startup ubuntu
echo '======== Creating passwordless login to root'
ssh-keygenTNR
echo '======== Testing Connection'
ssh-copy-id root@localhost
ssh ssh-copy-id root@localhost
exit
echo '======== Success'
cd ~
echo 'Configure SSH Daemon'
vim /etc/ssh/sshd_config
sudo sed -i -e 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config




