#!/bin/sh

echo "get and install docker-compose"
curl -L https://github.com/docker/compose/releases/download/1.4.0/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose
chmod +x /tmp/docker-compose
sudo mv -f /tmp/docker-compose /usr/local/bin/docker-compose

echo "fetch repo from github"
cd /srv
git clone https://github.com/umputun/ghost-buster-docker.git

echo "edit params"
cd /srv/ghost-buster-docker
nano /srv/ghost-buster-docker/docker-compose.yml

echo "start ghost and nginx"
cd /srv/ghost-buster-docker
docker-compose up -d

echo "all done"
