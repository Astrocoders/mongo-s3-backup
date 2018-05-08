# Mongo S3 Backup

This container runs a cron job which:

- dumps a mongo database using `mongodump`
- archives the dump and uploads it to Amazon S3

You can configure the execution of the above steps by setting the following
environment variables:

* `MONGO_HOST`
* `MONGO_DB`
* `MONGO_PORT`
* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `S3_BUCKET`
* `BACKUP_FILENAME_PREFIX`, optional, defaults to `mongo_backup`
* `BACKUP_FILENAME_DATE_FORMAT`, optional, defaults to `%Y%m%d`
* `CRON_SCHEDULE`, optional, defaults to `0 * * * *`


## Running

```
docker run --name mongo-backup --link mongodb:mongodb -e MONGO_HOST=mongodb -e MONGO_DB=app -e MONGO_PORT=27017 -e AWS_ACCESS_KEY_ID="YOURKEY" -e
AWS_SECRET_ACCESS_KEY="YOURACCESS" -e S3_BUCKET=yourbucketname -e CRON_SCHEDULE="0 * * * *" -d astrocoders/mongo-s3-backup
```
