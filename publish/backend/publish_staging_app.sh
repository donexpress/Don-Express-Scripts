#!/bin/bash

echo $2
app=$3

if [ $2 == 'front' ]
then
    environment="fe"
fi
if [ $2 == 'back' ]
then
    environment="be"
fi

echo docker pull registry.donexpress.com/$environment-$app-name:staging;

cd ~/donex_$2/

git stash;

git pull origin $4;

git checkout $4;

docker-compose -f docker-compose.yml -f docker-compose.qa.yml up -d;