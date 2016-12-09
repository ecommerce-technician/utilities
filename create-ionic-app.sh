#!bin/bash
ionic start {name} sidemenu
cd {name}
ionic platform add android
ionic build android
ionic emulate
ionic serve
#Set autoreload memory limit higher
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

    

