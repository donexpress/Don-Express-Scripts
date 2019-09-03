#!/bin/bash
# vars
BACKUPS_PATH="/opt/backups";
CURRENT_DATE_TIME="`date +%d-%m-%Y`";
FILE_NAME="$BACKUPS_PATH/donex_db_backup"
DATABASE_NAME="donex_db_backup_${CURRENT_DATE_TIME}.sql";

export PGUSER=postgres
export PGPASSWORD=postgres;

# generate and accessing backup_path
mkdir -p $BACKUPS_PATH;
mkdir -p $FILE_NAME;
cd $BACKUPS_PATH;

# We set the default permissions
umask 177

# dump
echo "processing the database copy..."
# pg_dump -h localhost --port 5432 -f ${DATABASE_NAME} $DB_NAME;
pg_dumpall -h localhost --port 5432 -f ${DATABASE_NAME};
echo "backup finished."

# get size of dump for the future
size="`wc -c $BACKUPS_PATH/$DATABASE_NAME`";
echo $size;

tar -cvzpf $FILE_NAME/donex_db_backup_$CURRENT_DATE_TIME.tar.gz $BACKUPS_PATH/$DATABASE_NAME

python $HOME/cron/alibaba_upload.py

#rm -rf $FILE_NAME
#rm $DATABASE_NAME

unset PGUSER
unset PGPASSWORD