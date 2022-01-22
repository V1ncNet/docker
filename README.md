# V1ncNet/docker

A collection of my Dockerfiles: https://hub.docker.com/u/vinado

## Images

- [nextcloud-preview-cron](nextcloud-preview-cron) - a simple Docker Image to schedule preview generation using the [Preview Generator](https://apps.nextcloud.com/apps/previewgenerator) Nextcloud app

## Stacks

- [nextcloud](https://github.com/V1ncNet/docker/tree/master/nextcloud-nginx) - a complete Docker Compose stack for running Nextcloud along with nginx
- [codimd](https://github.com/V1ncNet/docker/tree/master/codimd) - a CodiMD Dockerfile and complete Docker Compose stack for running CodiMD
- [invoiceplane](https://github.com/V1ncNet/docker/tree/master/invoiceplane) - an InvoicePlane Dockerfile and complete Docker Compose stack for running InvoicePlane

## Backup Services

- [nextcloud](https://github.com/V1ncNet/docker/tree/master/backup-nextcloud) - a backup service to backup Nextcloud data and PostgreSQL database
- [mysql](https://github.com/V1ncNet/docker/tree/master/backup-mysql) - a backup service to backup a MySQL database
- [codimd](https://github.com/V1ncNet/docker/tree/master/backup-codimd) - a backup service to backup CodiMD uploads and PostgreSQL database
