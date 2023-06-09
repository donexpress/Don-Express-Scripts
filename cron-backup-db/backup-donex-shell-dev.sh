#!/bin/bash
# vars
BACKUPS_PATH="/tmp/backups/dev";
CURRENT_DATE_TIME="`date +%Y-%m-%d`";
FILE_NAME="$BACKUPS_PATH/donex_db_backup"

export PGUSER=backup
export PGPASSWORD=mustbackupdb....!!!!

# generate and accessing backup_path
mkdir -p $BACKUPS_PATH;
mkdir -p $FILE_NAME;
cd $BACKUPS_PATH;

# We set the default permissions
umask 177

# Declare Database array variable
declare -a db=("donex_accounts_dev" "donex_catalog_dev" "donex_cms_dev" "donex_customer_service_dev" "donex_files_dev" "donex_forex_dev" "donex_gateway_dev" "donex_logistics_dev" "donex_notifications_dev" "donex_os_dev" "donex_payments_dev" "donex_redirect_dev" "donex_wallet_dev" "donex_atm_dev" "donex_hermes_dev")

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

#Upload db alibaba 
#python /home/admin/donex_scripts/cron-backup-db/alibaba_upload.py

rm -rf $FILE_NAME
#rm $DATABASE_NAME

unset PGUSER
unset PGPASSWORD