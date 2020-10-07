#!/bin/bash
echo '#############';
echo $1;
echo $2;
echo $3;
echo $4;
echo '#############';

# Setting the environment comes from the frontend or the backend
if [ $1 == 'front' ]
then
    environment="fe"
fi
if [ $1 == 'back' ]
then
    environment="be"
fi

if [[ ($2 != 'customer_service') && ($2 != 'cs_channel') ]];
then
    docker pull registry.donexpress.com/$environment-$2:$3;
else
    if [ $2 == 'customer_service' ]
    then
        app="customer-service"
        docker pull registry.donexpress.com/$environment-$app:$3;
    fi
    if [ $2 == 'cs_channel' ]
    then
        app="cs-channel"
        docker pull registry.donexpress.com/$environment-$app:$3;
    fi
fi

if [[ $3 != 'staging' && $3 != 'master' ]]
then
    echo "$4=$3" >> ~/.env.cluster;
fi

cd ~/donex_$2/

git stash;

git pull origin $3;

#git checkout $3;

if [ $3 == 'master' ]
then
    docker-compose -f docker-compose.yml -f docker-compose.master.yml up -d;
    exit 0;
fi
if [ $3 == 'staging' ]
then
    docker-compose -f docker-compose.yml -f docker-compose.qa.yml up -d;
    exit 0;
fi

dkst "$2"

function dkst (){
    for c in "$@" do
        docker ps | awk "/$c/ { print \$1 }" |
        while read data; do
            docker stop $data
        done
    done
}