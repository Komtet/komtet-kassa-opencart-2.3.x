FROM php:7.2-apache AS php7
RUN docker-php-ext-install mysqli

RUN echo "deb http://archive.debian.org/debian/ buster main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security buster/updates main contrib non-free" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y libzip-dev \
    && docker-php-ext-install zip

RUN apt-get update && apt-get install -y \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxpm-dev \
    libfreetype6-dev

RUN docker-php-ext-configure gd \
    --with-gd \
    --with-jpeg-dir \
    --with-webp-dir \
    --with-png-dir \
    --with-zlib-dir \
    --with-xpm-dir \
    --with-freetype-dir

RUN docker-php-ext-install gd

WORKDIR /var/www/html
COPY php .
