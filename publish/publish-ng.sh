#!/bin/bash

# dir local MS
localFolder="/home/admin/scripts/publish/repos"
# Folder MS
localPath=$localFolder"/donex_$2/"

MsPath="/var/www/donex_$2"

cd $localPath

# git check rama
git stash;

git pull origin staging;

git checkout staging;

#if [ ! -d "node_modules" ]; then
npm install;

if [ -d "node_modules/node-sass" ]; then
  npm rebuild node-sass;
fi
#fi

#rm -rf package-lock.json;

rm -rf $localPath"/dist";

ng build --prod;

#npm update;

rm -rf $MsPath"/dist";

cp -rf $localPath"dist/" $MsPath;
