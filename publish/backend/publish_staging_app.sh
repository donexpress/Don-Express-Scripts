#!/bin/bash
echo '#############';
echo $1;
echo $2;
echo $3;
echo '#############';

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
    docker pull registry.donexpress.com/$environment-$2:staging;
else
    if [$2 == 'customer_service']
    then
        app="customer-service"
        echo docker pull registry.donexpress.com/$environment-$app:staging
        docker pull registry.donexpress.com/$environment-$app:staging;
    fi
    if [$2 == 'cs_channel']
    then
        app="cs-channel"
        echo docker pull registry.donexpress.com/$environment-$app:staging
        docker pull registry.donexpress.com/$environment-$app:staging;
    fi
fi

cd ~/donex_$2/

#git stash;
if [$3 == 'master']
then
    exit 1;
fi
git pull origin $3;

#git checkout $3;

docker-compose -f docker-compose.yml -f docker-compose.qa.yml up -d;