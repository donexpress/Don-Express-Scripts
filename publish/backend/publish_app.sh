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
    if [ $2 == 'payments' ]
    then
        app="payments-jobs"
        docker pull registry.donexpress.com/$environment-$app:$3;
    fi
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

if [ $2 == 'customer_service' ]
then
    app="customer-service";
    docker tag registry.donexpress.com/$environment-$app:$3 registry.donexpress.com/$environment-$app:dc0-latest;
fi
if [ $2 == 'cs_channel' ]
then
    app="cs-channel";
    docker tag registry.donexpress.com/$environment-$app:$3 registry.donexpress.com/$environment-$app:dc0-latest;
fi
if [[ ($2 != 'customer_service') && ($2 != 'cs_channel') ]];
then
    docker tag registry.donexpress.com/$environment-$2:$3 registry.donexpress.com/$environment-$2:dc0-latest
fi

docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d;