#!/bin/bash
#Add server backend

cd ~/donex_$2/

if [ $branch == "null" ]
then
      # git check rama
      git stash;

      git pull origin staging;

      git checkout staging;
else
      git stash;

      git pull origin $3;

      git checkout $3;
fi

#dcbstg 

#dcustg -d

docker-compose -f docker-compose.yml -f docker-compose.staging.yml build

docker-compose -f docker-compose.yml -f docker-compose.staging.yml up -d
