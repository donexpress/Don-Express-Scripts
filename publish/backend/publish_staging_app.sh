#!/bin/bash

if [ $1 == 'front' ]
then
    environment="fe"
fi
if [ $1 == 'back' ]
then
    environment="be"
fi

echo docker pull registry.donexpress.com/$environment-$2:staging;

cd ~/donex_$2/

git stash;

git pull origin $3;

#git checkout $3;

docker-compose -f docker-compose.yml -f docker-compose.qa.yml up -d;