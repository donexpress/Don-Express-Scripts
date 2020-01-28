#!/bin/bash

# dir local MS
localFolder="/home/admin/scripts/publish/repos"
# Folder MS
localPath=$localFolder"/donex_$2/"

MsPath="/var/www/donex_$2"
value="$2"

cd $localPath

# git check rama
git stash;

git pull;

if [[ ($value != "auth") && ($value != "cs_channel") && ($value != "boutique") && ($value != "buy") ]];
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
