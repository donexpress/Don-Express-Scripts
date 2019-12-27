#!/bin/bash
# dir local MS
localFolder="/home/admin/scripts/publish-ng/repos/"
# Folder MS
localPath=$localFolder"/donex_$2/"

MsPath="/var/www/donex_$2"

cd $localPath

# git check rama
git checkout master;

git pull;

#if [ ! -d "node_modules" ]; then
npm install;
npm rebuild node-sass;
#fi

ng build --prod

rm -rf $MsPath"/dist"

cp -r "dist/" $MsPath