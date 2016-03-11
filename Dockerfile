FROM php:latest
RUN apt-get update && apt-get install -y \
        jq \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libpq-dev \
        libzip-dev \
        zlib1g-dev \
        git \
    && docker-php-ext-install -j$(nproc) iconv mbstring mcrypt pdo pdo_mysql pdo_pgsql zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && curl -Lo /usr/local/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && chmod +x /usr/local/bin/phpcs \
    && curl -Lo /usr/local/bin/phpmd http://static.phpmd.org/php/latest/phpmd.phar \
    && chmod +x /usr/local/bin/phpmd
