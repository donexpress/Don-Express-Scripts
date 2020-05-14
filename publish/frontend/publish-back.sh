#!/bin/bash
#Repo Frontend invoke sh backend

app=$2
echo $app
ssh -i ~/.ssh/id_back_rsa admin@47.254.41.112 "sh /home/admin/donex_script/publish_back.sh" + $2 $3
