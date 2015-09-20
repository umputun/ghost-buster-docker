#!/bin/sh

echo "get and install docker-compose"
curl -L https://github.com/docker/compose/releases/download/1.4.0/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose
chmod +x /tmp/docker-compose
sudo mv -f /tmp/docker-compose /usr/local/bin/docker-compose

cd ./ghost-buster-docker

echo "edit params"
nano ./ghost-buster-docker/docker-compose.yml

echo "start ghost and nginx"
docker-compose up -d

echo "all done"
