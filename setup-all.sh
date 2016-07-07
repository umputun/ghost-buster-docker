#!/bin/sh


# Docker compose is apart of Docker

echo "edit params"
nano docker-compose.yml

# making necessary path and files
mkdir -p logs
touch logs/access.log
touch logs/error.log
touch logs/ghost-buster.log

echo "build container"
docker-compose build

echo "start ghost and nginx"
docker-compose up

echo "all done"
