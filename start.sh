#!/bin/bash

CRON_SCHEDULE=${CRON_SCHEDULE:-0 * * * *}
CRON_ENVIRONMENT="
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?"env variable is required"}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?"env variable is required"}
MONGO_HOST=${MONGO_HOST:?"env variable is required"}
MONGO_PORT=${MONGO_PORT:?"env variable is required"}
MONGO_DB=${MONGO_DB:?"env variable is required"}
S3_BUCKET=${S3_BUCKET:?"env variable is required"}
AWS_DEFAULT_REGION=$(python /script/get_bucket_region.py $S3_BUCKET)
BACKUP_FILENAME_DATE_FORMAT=${BACKUP_FILENAME_DATE_FORMAT:-%Y%m%d%hh}
BACKUP_FILENAME_PREFIX=${BACKUP_FILENAME_PREFIX:-mongo_backup}
"
CRON_COMMAND="/script/backup.sh 1>/var/log/backup_script.log 2>&1"

echo
echo "Configuration"
echo
echo "CRON_SCHEDULE"
echo
echo "$CRON_SCHEDULE"
echo
echo "CRON_ENVIRONMENT"
echo "$CRON_ENVIRONMENT"

echo "$CRON_ENVIRONMENT$CRON_SCHEDULE $CRON_COMMAND" | crontab -
mkfifo /var/log/backup_script.log
cron
tail -f /var/log/backup_script.log
