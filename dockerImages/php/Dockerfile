FROM php:7.4-fpm

LABEL maintanier = "Innocent Root <innocentakomagbe@gmail.com>"

RUN apt-get update && apt-get install -y --no-install-recommends \
    coreutils \
    openssl \
    curl \
    git \
    zip \
    unzip \
    libedit-dev \
    libfcgi0ldbl \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpq-dev \
    supervisor \
    && rm -r /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install \
    pdo_mysql \
    gd \
    intl

# configure intl
RUN docker-php-ext-configure intl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
&& composer --version

# COnfigure timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
COPY timezone.ini  /etc/php/7.3/fpm/conf.d/


# Install nginx as webserver
RUN apt-get update && apt-get install -y --no-install-recommends nginx openssl coreutils

# COPY config files
COPY nginx.conf /etc/nginx/
COPY sdocker.conf /etc/nginx/sites-available
COPY sdocker.pool.conf /usr/local/etc/php-fpm.d/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Remove default configuration
RUN rm /etc/nginx/sites-enabled/default

# Enable sdocker site
RUN ln -s /etc/nginx/sites-available/sdocker.conf /etc/nginx/sites-enabled/

RUN mkdir /run/php

EXPOSE 9001
WORKDIR /var/www/sdocker

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

