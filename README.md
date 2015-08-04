![elk-logo](https://raw.githubusercontent.com/blacktop/docker-elk/master/elk-logo.png)
Password Protected ELK Stack Dockerfile
===================

[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

This repository contains a **Dockerfile** of [ELK](http://www.elasticsearch.org/overview/elkdownloads/) for [Docker](https://www.docker.io/).

### Dependencies

* [java:8-jre](https://registry.hub.docker.com/_/java/)

### Installation

1. Install [Docker](https://www.docker.io/):

2. Build an image from Dockerfile
```bash
$ docker build -t dvitonis/elk github.com/dvitonis/docker-elk
```
### Usage
```bash
$ chmod +x deploy.sh
$ sh deploy.sh
```
The deploy.sh script will prompt you for the passwords of Kibana user `admin` and ElasticSearch user `es`.
