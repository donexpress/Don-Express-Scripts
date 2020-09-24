#!/bin/bash
# vars
BACKUPS_PATH="/tmp/backups";
CURRENT_DATE_TIME="`date +%Y-%m-%d`";
FILE_NAME="$BACKUPS_PATH/donex_db_backup"

export PGUSER=donex_backup_user213
export PGPASSWORD=mustbackupdb....!!!!

# generate and accessing backup_path
mkdir -p $BACKUPS_PATH;
mkdir -p $FILE_NAME;
cd $BACKUPS_PATH;

# We set the default permissions
umask 177

# Declare Database array variable
declare -a db=("donex_accounts_astick" "donex_audit_gendol" "donex_catalog_didech" "donex_cms_newive" "donex_customer_service_fularl" "donex_files_vilipa" "donex_forex_cgogro" "donex_forex_chuend" "donex_gateway_rocrom" "donex_logistics_atexon" "donex_notifications_ayfere" "donex_os_tionig" "donex_payments_ineque" "donex_redirect_heropo" "donex_social_vdampa" "donex_wallet_stetra")

echo "******************"
for db in "${db[@]}"
do
  DATABASE_NAME="${db}"
  DATABASE_NAME_BACKUP="${db}_backup_${CURRENT_DATE_TIME}.dump"
  echo "${DATABASE_NAME} bachup finished."
  pg_dump -U backup -h localhost --port 5432 -x -O -f $FILE_NAME/${DATABASE_NAME_BACKUP} ${DATABASE_NAME};
 
done
echo "******************"

tar -cvzpf $BACKUPS_PATH/donex_db_backup_$CURRENT_DATE_TIME.tar.gz $FILE_NAME

# get size of dump for the future
size="`wc -c $BACKUPS_PATH/donex_db_backup_$CURRENT_DATE_TIME.tar.gz`";
echo $size;

python /home/admin/scripts/backup/alibaba_upload.py

rm -rf $FILE_NAME
#rm $DATABASE_NAME

unset PGUSER
unset PGPASSWORD