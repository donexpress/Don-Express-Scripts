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

git pull origin staging;

git checkout staging;

yarn install

yarn build
  
rm -rf $MsPath;

cp -r $localPath $MsPath;

#pm2 restart donex_$2
