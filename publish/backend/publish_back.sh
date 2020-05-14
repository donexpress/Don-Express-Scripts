#!/bin/bash

cd ~/donex_$2/

git stash;

git pull origin $3;

git checkout $3;

docker-compose -f docker-compose.yml -f docker-compose.staging.yml build

docker-compose -f docker-compose.yml -f docker-compose.staging.yml up -d
