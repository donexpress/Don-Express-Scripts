#!/bin/bash

# dir local MS
localFolder="/home/admin/scripts/publish/repos"
# Folder MS
localPath=$localFolder"/donex_$2/"

MsPath="/var/www/donex_$2"

cd $localPath

if [[ (-z "$3") && (-n "$3") ]]
then
      # git check rama
      git stash;

      git pull origin staging;

      git checkout staging;
else
      git stash;

      git pull origin $3;

      git checkout $3;
fi

npm install;

if [ -d "node_modules/node-sass" ]; then
  npm rebuild node-sass;
fi

rm -rf $localPath"/dist";

ng build --prod;

if [ -d $localPath"/dist" ]; then
  rm -rf $MsPath"/dist";

  cp -rf $localPath"dist/" $MsPath;
fi
