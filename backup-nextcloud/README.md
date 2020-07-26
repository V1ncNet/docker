# Nextcloud Backup Service

This Docker image provides a backup service to backup Nextcloud data and PostgreSQL database. The service can be added into a docker stack with a PostgreSQL instance to backup the database periodically.

When a new backup is made, files from the older backups are hard-linked. This keeps the increments small because they only contain the delta from the previous backup.

## Features

- PostgreSQL database dumps using `pg_dump`
- Nextcloud file snapshots using `tar`
- Backup compression using `zstd`
- Configurable Cronjob
- Configurable rotations

This service doesn't provide any restore function yet.

## Environment

- CRON_PERIOD - Cron expression
- NEXTCLOUD_VOLUME - Nextcloud files directory (usually `/var/www/html`)
- BACKUP_ROTATIONS - Number of backups to be kept locally (default 4)

All backups are located in `/backups/nextcloud_<date>`.

### Scripts

All scripts are located in `/usr/local/bin` and can be called manually. E.g.

```sh
docker exec nextcloud_backup docker-entrypoint.sh backup
```

## Deployment

The service is supposed to be part of a Docker service stack.

```yaml
version: '2'

services:
  database:
    image: postgres
    [...]

  nextcloud:
    image: nextcloud
    depends_on:
      - database
    volumes:
      - nextcloud:/var/www/html
    [...]

  backup:
    image: vinado/backup-nextcloud:latest
    depends_on:
      - nextcloud
    volumes:
      - nextcloud:/var/www/html:ro
      - backups:/backups
    environment:
      CRON_PERIOD: "0 0 * * 1"
      NEXTCLOUD_VOLUME: "/var/www/html"
      BACKUP_ROTATIONS: 4

volumes:
  nextcloud:
    driver: local
  backups:
    driver: local
```

## Contribute

The source is available on [GitHub](https://github.com/V1ncNet/docker). Please [report any issues](https://github.com/V1ncNet/docker/issues).

To build the image from the Dockerfile run:

```sh
docker build -t vinado/backup-nextcloud:latest .
```
