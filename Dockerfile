FROM nothingspare/oakridge-wordpress-base:dev

# Config, enable memcache
RUN apt-get update && apt-get install -y libmemcached-dev zlib1g-dev \
  && pecl install memcached-3.0.3 \
  && docker-php-ext-enable memcached

RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache
COPY opcache.ini /usr/local/etc/php

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
