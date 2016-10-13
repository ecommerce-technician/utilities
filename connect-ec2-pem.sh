#!bin/bash
echo 'connect to ec2  using pem key, make sure you downloaded the pemkey to your ~/Downloads dir'
cp ~/Downloads/DAKey.pem /home/{USER}/.ssh/
sudo chmod 400 /home/{USER}/.ssh/DAKey.pem
ssh -i ~/.ssh/DAKey.pem ubuntu@$ip

