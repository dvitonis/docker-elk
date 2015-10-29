#!/bin/bash

set -e

apt-get install apache2-utils -y

mkdir /tmp -p

echo Creating admin user for Kibana
htpasswd -c /tmp/.htpasswd admin
echo Creating es user for Elastic Search
htpasswd -c /tmp/.espasswd es

echo Creating certificate
openssl genrsa -out /tmp/privkey.pem 2048
openssl req -new -x509 -key /tmp/privkey.pem -out /tmp/cacert.pem -days 1095

echo Starting docker containers
docker run --name kibana-data --entrypoint /bin/echo dvitonis/elk Data-only container
docker run -dit --name elk --volumes-from kibana-data -p 443:443 -p 9200:9201 --restart always dvitonis/elk

docker run --rm --volumes-from kibana-data -v /tmp:/tmp dvitonis/elk cp /tmp/cacert.pem /etc/nginx
docker run --rm --volumes-from kibana-data -v /tmp:/tmp dvitonis/elk cp /tmp/privkey.pem /etc/nginx

docker run --rm --volumes-from kibana-data -v /tmp:/tmp dvitonis/elk cp /tmp/.htpasswd /etc/nginx
docker run --rm --volumes-from kibana-data -v /tmp:/tmp dvitonis/elk cp /tmp/.espasswd /etc/nginx