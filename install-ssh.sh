#!bin/bash
echo "install open-ssh and gen pubkey"
apt-get install openssh-server
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa
/etc/init.d/ssh restart
