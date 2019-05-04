#!/bin/bash

set -e

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

