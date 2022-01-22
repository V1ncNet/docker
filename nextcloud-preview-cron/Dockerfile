ARG NEXTCLOUD_VERSION=latest

FROM nextcloud:${NEXTCLOUD_VERSION}

ARG CRON_EXPRESSION="*/10 * * * *"
ENV CRON_EXPRESSION=${CRON_EXPRESSION}

RUN echo "${CRON_EXPRESSION} php /var/www/html/occ preview:pre-generate" > /var/spool/cron/crontabs/www-data

ENTRYPOINT [ "/cron.sh" ]
