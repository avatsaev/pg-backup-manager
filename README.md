# Postgres backup manager

This image runs pg_dump to backup data using cronjob to folder `/backup` (compatible with postgres 10 and 11, use the appropriate tags)

## Usage:

    docker run -d \
        --env POSTGRES_HOST=mysql.host \
        --env POSTGRES_PORT=27017 \
        --env POSTGRES_USER=admin \
        --env POSTGRES_PASSWORD=password \
        --volume host.folder:/backup
        avatsaev/pg-backup-manager

## Parameters

    POSTGRES_HOST      the host/ip of your postgres database
    POSTGRES_PORT      the port number of your postgres database
    POSTGRES_USER      the username of your postgres database
    POSTGRES_PASSWORD      the password of your postgres database
    POSTGRES_DB        the database name to dump. Default: `--all-databases`
    EXTRA_OPTS      the extra options to pass to pg_dump command
    CRON_TIME       the interval of cron job to run pg_dump. `0 0 * * *` by default, which is every day at 00:00
    MAX_BACKUPS     the number of backups to keep. When reaching the limit, the old backup will be discarded. No limit by default
    INIT_BACKUP     if set, create a backup when the container starts
    INIT_RESTORE_LATEST if set, restores latest backup

    INIT_RESTORE_URL restore from minio url ex: myminio/bla/file.sql 
    MINIO_HOST name of minio host ex: myminio
    MINIO_HOST_URL ex: https://myminio.my.io
    MINIO_ACCESS_KEY minio access key
    MINIO_SECRET_KEY minio secret key

## Restore from a backup

See the list of backups, you can run:

    docker exec pg-backup-manager ls /backup

To restore database from a certain backup, simply run:

    docker exec pg-backup-manager /restore.sh /backup/2015.08.06.171901
