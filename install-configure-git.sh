#!bin/bash
echo 'installing git'
apt-get install git
git config --global user.name "${USER}"
git config --global user.email "${EMAIL}"
git config --global core.editor vim
