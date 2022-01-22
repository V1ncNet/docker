FROM archlinux

LABEL maintainer="vincent.nadoll@gmail.com"

RUN pacman -Syu --noconfirm && pacman -S --noconfirm \
    cronie \
    postgresql-libs \
 && rm -Rf /var/cache/pacman/pkg/

COPY backup               /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/

RUN mkdir /backups
VOLUME    /backups

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["cron"]
