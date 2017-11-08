# php-fpm
FROM php:fpm

# install PHP extensions
# gd, mysql-cli, memcached, opcached, git, ssmtp
RUN apt-get update \
    && apt-get -y install \
        libmemcached11 \
        libmemcachedutil2 \
        libmemcached-dev \
        mysql-client \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libz-dev \
        libxml2-dev \
        ssmtp \
        git \
    && pecl install memcached \
    && docker-php-ext-install gd mysqli pdo pdo_mysql opcache mbstring soap \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
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
    && apt-get remove -y build-essential libz-dev libmemcached-dev libxml2-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /tmp/pear

# install composer and wp-cli
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && wp --allow-root --version
