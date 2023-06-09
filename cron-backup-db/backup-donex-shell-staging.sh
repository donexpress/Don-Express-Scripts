#!/bin/bash
# vars
BACKUPS_PATH="/tmp/backups/staging";
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
declare -a db=("donex_accounts_staging" "donex_audit_staging" "donex_catalog_staging" "donex_cms_staging" "donex_customer_service_staging" "donex_files_staging" "donex_forex_staging" "donex_gateway_staging" "donex_logistics_staging" "donex_notifications_staging" "donex_os_staging" "donex_payments_staging" "donex_redirect_staging" "donex_social_staging" "donex_wallet_staging" "donex_atm_staging" "donex_hermes_staging")

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
python /home/admin/donex_scripts/cron-backup-db/alibaba_upload.py

rm -rf $FILE_NAME
#rm $DATABASE_NAME

unset PGUSER
unset PGPASSWORD