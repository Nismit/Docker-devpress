# php-fpm 
# NOTICE, YOU SHOULD FIX PHP VERSION, IT ALWAYS GET LATEST VERSION
FROM php:fpm

# install memcached extension for php
# gd, mysql, opcache, mbstring
RUN apt-get update \
  && apt-get -y install \
  zlib1g-dev libmemcached-dev libmemcached11 libmemcachedutil2 \
  libjpeg62-turbo-dev libpng12-dev \
  && pecl install memcached \
  && docker-php-ext-configure gd --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install gd mysqli opcache mbstring \
  && echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini \
  && docker-php-ext-enable memcached \
  && { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=2'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
  } > /usr/local/etc/php/conf.d/opcache-recommended.ini \  
  && docker-php-ext-enable opcache \
  && apt-get remove -y zlib1g-dev libmemcached-dev \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /tmp/pear

# install composer and wp-cli
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && composer --version \
  && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && wp --allow-root --version
    