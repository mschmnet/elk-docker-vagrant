#!/bin/bash

set -e

nginx(){
  sudo apt-get install -y nginx apache2-utils
  sudo openssl req -x509 -batch -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/private/kibana-access.key -out /etc/ssl/certs/kibana-access.pem
  sudo bash -c 'cat > /etc/nginx/conf.d/kibana.conf << EOF
server {
    listen 80;
    listen [::]:80;
    return 301 https://$host$request_uri;
}

server {
    listen 443 default_server;
    listen            [::]:443;
    ssl on;
    ssl_certificate /etc/ssl/certs/kibana-access.pem;
    ssl_certificate_key /etc/ssl/private/kibana-access.key;
    access_log            /var/log/nginx/nginx.access.log;
    error_log            /var/log/nginx/nginx.error.log;
    location / {
        auth_basic "Restricted";
        auth_basic_user_file /etc/nginx/conf.d/kibana.htpasswd;
        proxy_pass http://localhost:5601/;
    }
}
EOF
'
  sudo rm /etc/nginx/sites-enabled/default
  # Remove this 'test' user and execute this command manually
  sudo htpasswd -b -c /etc/nginx/conf.d/kibana.htpasswd test test-pass
  sudo nginx -s reload
  sudo systemctl restart nginx
}



sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt install -y python3-pip
pip3 install docker-compose
# To set value permanently:
sudo bash <<< 'echo "vm.max_map_count=262144" >> /etc/sysctl.conf'
# For current session:
sudo sysctl -w vm.max_map_count=262144
. .profile
sudo usermod -aG docker vagrant

if [[ "$http_proxy" != "" ]]
then
  sudo mkdir -p /etc/systemd/system/docker.service.d
  sudo bash -c 'cat > /etc/systemd/system/docker.service.d/http-proxy.conf << EOF
[Service]
Environment="HTTP_PROXY=$http_proxy"
EOF
  '
  sudo systemctl daemon-reload
  sudo systemctl restart docker
fi	

nginx
