# php-fpm
FROM php:fpm-alpine

ENV MEMCACHED_DEPS \
      zlib-dev \
      libmemcached-dev \
      cyrus-sasl-dev

# install PHP extensions
# gd, mysql-cli, memcached, opcached, ssmtp
RUN set -ex \
    && apk add --no-cache --update \
        bash \
        mysql-client \
        ssmtp \
        libmemcached \
        freetype \
        libjpeg-turbo \
        libpng \
    && apk add --no-cache --update --virtual .phpize-deps \
        $PHPIZE_DEPS \
    && apk add --no-cache --update --virtual .build-deps \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libxml2-dev \
        $MEMCACHED_DEPS \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include --with-png-dir=/usr/include --with-jpeg-dir=/usr/include \
    && docker-php-ext-install gd mysqli opcache mbstring soap \
    && pecl install memcached \
    && { \
      echo 'extension=memcached.so'; \
      echo 'session.save_handler = memcached'; \
      echo 'session.save_path = memcached:11211'; \
      } > /usr/local/etc/php/conf.d/memcached.ini \
    && { \
      echo 'opcache.memory_consumption=128'; \
      echo 'opcache.interned_strings_buffer=8'; \
      echo 'opcache.max_accelerated_files=4000'; \
      echo 'opcache.revalidate_freq=2'; \
      echo 'opcache.fast_shutdown=1'; \
      echo 'opcache.enable_cli=1'; \
      } > /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && echo 'mailhub=mailcatcher:1025\nUseTLS=NO\nFromLineOverride=YES' > /etc/ssmtp/ssmtp.conf \
    && docker-php-ext-enable opcache memcached \
    && apk del .phpize-deps .build-deps

# install composer and wp-cli
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && wp --allow-root --version
