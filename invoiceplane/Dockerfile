FROM php:7.4-apache-buster
LABEL maintainer="vincent.nadoll@gmail.com"

# Install and configure PHP mods
RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        netcat \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        librecode-dev \
        libxml2-dev \
        libonig-dev \
        unzip \
    ; \
    \
    docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg; \
    \
    curl -fsSL -o recode.zip \
        "https://github.com/php/pecl-text-recode/archive/master.zip"; \
    unzip recode.zip; \
    cd pecl-text-recode-master; \
    phpize; \
    ./configure; \
    make; \
    make install; \
    \
    pecl install mcrypt-1.0.3; \
    docker-php-ext-enable mcrypt recode; \
    \
    docker-php-ext-install -j$(nproc) \
        gd \
        json \
        mysqli \
        xmlrpc \
    ; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

VOLUME /var/www/html

## Configure Apache HTTPD mods
RUN a2enmod rewrite

ARG INVOICEPLANE_VERSION="1.5.11"
ENV INVOICEPLANE_VERSION=${INVOICEPLANE_VERSION}

## Download and install InvoicePlane
RUN set -ex; \
    \
    fetchDeps=" \
        unzip \
    "; \
    apt-get update; \
    apt-get install -y --no-install-recommends $fetchDeps; \
    \
    curl -fsSL -o invoiceplane.zip \
        "https://github.com/InvoicePlane/InvoicePlane/releases/download/v${INVOICEPLANE_VERSION}/v${INVOICEPLANE_VERSION}.zip"; \
    unzip invoiceplane.zip -d /var/www/html; \
    rm invoiceplane.zip; \
    \
    chown -R www-data:www-data /var/www; \
    chmod -R g=u /var/www; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $fetchDeps; \
    rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
