FROM php:5.5.32-fpm
RUN apt-get -y update
RUN apt-get -y install php5-mysql
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libssl-dev \
        libc-client2007e-dev \
        libkrb5-dev \
        bzip2 \
        zlib1g-dev \
        pwgen
RUN docker-php-ext-install -j$(nproc) iconv mcrypt
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) mysqli
RUN docker-php-ext-install -j$(nproc) pdo_mysql
RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-install -j$(nproc) zip
RUN docker-php-ext-install -j$(nproc) imap
COPY php.ini /usr/local/etc/php/
