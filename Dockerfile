FROM php:latest

RUN apt-get update && apt-get install -y \
        jq \
        libbz2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libpq-dev \
        libzip-dev \
        zlib1g-dev \
        git \
    && docker-php-ext-install -j$(nproc) bz2 iconv mbstring mcrypt pdo pdo_mysql pdo_pgsql zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN curl -Lo /usr/local/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && chmod +x /usr/local/bin/phpcs
RUN curl -Lo /usr/local/bin/phpmd http://static.phpmd.org/php/latest/phpmd.phar && chmod +x /usr/local/bin/phpmd
RUN curl -Lo /usr/local/bin/phpmetrics https://github.com/phpmetrics/PhpMetrics/raw/master/build/phpmetrics.phar \
    && chmod +x /usr/local/bin/phpmetrics
