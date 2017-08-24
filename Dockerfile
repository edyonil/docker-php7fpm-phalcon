FROM php:7.1-fpm
MAINTAINER Edyonil <edyonil>

ENV PHALCON_VERSION=3.2.2
ENV DEBIAN_FRONTEND noninteractive

# Dependencies
RUN apt-get update
RUN apt-get install -y wget libpcre3-dev gcc make re2c git-core

# Compile Phalcon
RUN git clone https://github.com/phalcon/cphalcon.git
RUN cd cphalcon/ &&  git checkout tags/v${PHALCON_VERSION}
RUN cd cphalcon/build && ./install
RUN echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini
RUN cd ../ && rm -rf cphalcon/

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

# PHP Extensions
RUN apt-get update

RUN apt-get install -y zip unzip zlib1g-dev
RUN docker-php-ext-install pdo pdo_mysql zip

RUN apt-get install -y libcurl4-openssl-dev
RUN docker-php-ext-install curl
