# Nextcloud Preview Generator Cron

This Docker image registers a cronjob to trigger preview generation for Nextcloud. The service should be added to an existing Nextcloud stack.

**Note**: In order to work the Nextcloud instance needs to have the [Preview Generator](https://apps.nextcloud.com/apps/previewgenerator) app installed. Follow their initial setup guide before activating this service.

## Build Arguments

**Default**

* NEXTCLOUD_VERSION="latest"
* CRON_EXPRESSION="*/10 * * * *"

If you want a different Nextcloud base image version you can do so by providing the build argument `NEXTCLOUD_VERSION`. The cron expression is also customizable. Provide your own by setting it though the `CRON_EXPRESSION` build argument.

Be aware that you cannot change such variables during container startup, **only** while you're building the image. So you need to build your own version to achieve the customizations mentioned above.

## Deployment

Make sure you mount the Nextcloud base directory at the same location as your Nextcloud service does.

```yml
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

  preview:
    image: vinado/nextcloud-preview-cron:22
    depends_on:
      - nextcloud
    volumes:
      - nextcloud:/var/www/html:ro

volumes:
  nextcloud:
    driver: local
```

## Contribute

The source is available on [GitHub](https://github.com/V1ncNet/docker). Please [report any issues](https://github.com/V1ncNet/docker/issues).

To build the image from the Dockerfile run:

```sh
docker build -t vinado/nextcloud-preview-cron:latest .

# Or for a different base image version or cron expression
docker build \
 --build-arg NEXTCLOUD_VERSION=22 \
 --build-arg CRON_EXPRESSION="*/15 * * * *" \
 -t vinado/nextcloud-preview-cron:latest .
```
