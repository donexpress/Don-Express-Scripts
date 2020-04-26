#!/bin/bash
#Add server backend

cd ~/donex_$2/

git pull origin staging

git checkout staging

#dcbstg 

#dcustg -d

docker-compose -f docker-compose.yml -f docker-compose.staging.yml build

docker-compose -f docker-compose.yml -f docker-compose.staging.yml up -d
