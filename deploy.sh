#!/bin/bash

set -e

apt-get install apache2-utils -y

mkdir /tmp -p

echo Creating admin user for Kibana
htpasswd -c /tmp/.htpasswd admin
echo Creating es user for Elastic Search
htpasswd -c /tmp/.espasswd es

echo Starting docker containers
docker run --name kibana-data --entrypoint /bin/echo dvitonis/elk Data-only container
docker run -dit --name elk --volumes-from kibana-data -p 80:80 -p 9200:9201 --restart always dvitonis/elk

docker run --rm --volumes-from kibana-data -v /tmp:/tmp dvitonis/elk cp /tmp/.htpasswd /etc/nginx
docker run --rm --volumes-from kibana-data -v /tmp:/tmp dvitonis/elk cp /tmp/.espasswd /etc/nginx