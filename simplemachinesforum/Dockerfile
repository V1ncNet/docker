FROM php:8.3-apache as downloader

RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        curl \
    ; \
    \
    curl -fsSL -o smf.tar.gz \
        https://download.simplemachines.org/index.php/smf_2-1-4_install.tar.gz; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*


FROM php:8.3-apache
LABEL maintainer="vincent.nadoll@gmail.com"

VOLUME  /var/www/html/

RUN a2enmod rewrite

COPY --from=downloader /var/www/html/smf.tar.gz .
COPY                   smf.conf                 /etc/apache2/conf-enabled/smf.conf
COPY                   smf.ini                  ${PHP_INI_DIR}/conf.d/smf.ini

RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y \
        aspell \
    ; \
    \
    tar -xzf smf.tar.gz; \
    rm smf.tar.gz; \
    \
    chown -R www-data:www-data /var/www; \
    chmod -R g=u /var/www; \
    \
    mv ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini; \
    docker-php-ext-install -j$(nproc) \
        mysqli \
    ; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

USER www-data
