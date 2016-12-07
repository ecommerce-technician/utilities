#bin/bash
username=sentrywave
echo "Hello create user with sudo priviledges, simply type the username to be created and hit [ENTER:]"
read username
adduser $username
usermod -aG sudo $username
su - $username
cd ~
echo "installing node & dependencies"
curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install nodejs
sudo apt-get install build-essential
cd ~
echo "writing app"
cat <<EOF >> index.js
var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
}).listen(8080, 'localhost');
console.log('Server running at http://localhost:8080/');
EOF
chmod +x ./index.js
./index.js
echo "testing app"
curl http://localhost:8080
echo "installing pm2"
sudo npm install -g pm2
pm2 start index.js
pm2 startup systemd
sudo su -c "env PATH=$PATH:/usr/bin pm2 startup systemd -u $username --hp /home/$username"
systemctl status pm2
echo "setting up nginx"
sudo apt-get install nginx
> /etc/nginx/sites-available/default
sudo cat <<EOF >> ~/test
server {
    listen 80;

    server_name example.com;

    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade '$http_upgrade';
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host '$host';
        proxy_cache_bypass '$http_upgrade';
    }
}
EOF
sudo nginx -t
sudo systemctl restart nginx

echo "updating firewall rules"
sudo ufw allow 'Nginx Full'

echo "prepare https"
sudo apt-get install letsencrypt

echo "retrieving certificate"
sudo systemctl stop nginx
sudo letsencrypt certonly --standalone


#### ALL THIS STUFF
sudo vim /etc/nginx/sites-enabled/default

# HTTP - redirect all requests to HTTPS:
server {
        listen 80;
        listen [::]:80 default_server ipv6only=on;
        return 301 https://$host$request_uri;
}

# HTTPS - proxy requests on to local Node.js app:
server {
        listen 443;
        server_name api.sentry-wave.com;

        ssl on;
        # Use certificate and key provided by Let's Encrypt:
        ssl_certificate /etc/letsencrypt/live/api.sentry-wave.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/api.sentry-wave.com/privkey.pem;
        ssl_session_timeout 5m;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';

        # Pass requests for / to localhost:8080:
        location / {
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-NginX-Proxy true;
                proxy_pass http://localhost:8080/;
                proxy_ssl_session_reuse off;
                proxy_set_header Host $http_host;
                proxy_cache_bypass $http_upgrade;
                proxy_redirect off;
        }
}




