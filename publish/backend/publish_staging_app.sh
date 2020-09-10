#!/bin/bash

echo $2
app=$3
branch=$4

if [ $2 == 'front' ]
then
    environment="fe"
fi
if [ $2 == 'back' ]
then
    environment="be"
fi

echo docker pull registry.donexpress.com/$environment-$app:staging;

cd ~/donex_$app/

git stash;

git pull origin $branch;

git checkout $branch;

docker-compose -f docker-compose.yml -f docker-compose.qa.yml up -d;