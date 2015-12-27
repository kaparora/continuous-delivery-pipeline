#! /bin/bash

DOCKER_REPO=10.65.57.126:5000/ruby-mysql-web
TAG=0.0.1-SNAPSHOT

docker build -t $DOCKER_REPO:$TAG .
docker push $DOCKER_REPO:$TAG
