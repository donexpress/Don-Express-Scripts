#!/bin/bash

# dir local MS
localFolder="/home/admin/scripts/publish/repos"
# Folder MS
localPath=$localFolder"/donex_$2/"

MsPath="/var/www/donex_$2"
value="$2"
branch="$3"

cd $localPath

git stash;
      
git pull origin $3;

git checkout $3;

if [[ ($value != "auth") && ($value != "cs_channel") && ($value != "boutique") && ($value != "buy") && ($value != "website") && ($value != "bid") && ($value != "logs") ]];
then
  npm install

  npm run build:ssr
  
  rm -rf $MsPath"/dist"

  cp -r $localPath"dist/" $MsPath
else
  # yarn
  yarn install

  yarn build
  
  rm -rf $MsPath;

  cp -r $localPath $MsPath;
fi

pm2 restart donex_$2
