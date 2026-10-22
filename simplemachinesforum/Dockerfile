FROM php:8.3.36-apache
LABEL maintainer="vincent.nadoll@gmail.com"

VOLUME  /var/www/html/

RUN a2enmod rewrite

COPY smf_2-1-8_install.tar.gz smf.tar.gz
COPY smf.conf                 /etc/apache2/conf-enabled/smf.conf
COPY smf.ini                  ${PHP_INI_DIR}/conf.d/smf.ini

RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y \
        aspell \
    ; \
    \
    echo "95ba29623ee6b1969c5004fd739ef3fffdd11876028340bad94f95cd99a36ce2  smf.tar.gz" | sha256sum -c -; \
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
