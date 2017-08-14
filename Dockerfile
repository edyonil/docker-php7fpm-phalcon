FROM php:fpm
MAINTAINER Edyonil <edyonil>

RUN echo deb http://packages.dotdeb.org jessie all >>  /etc/apt/sources.list
RUN echo deb-src http://packages.dotdeb.org jessie all >>  /etc/apt/sources.list

# Phalcon repository
RUN apt-get update
RUN apt-get install -y wget curl
RUN curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash

# Php modules
RUN apt-get update
RUN apt-get install -y --force-yes php7.0-phalcon php7.0-mysql php7.0-mcrypt php7.0-zip php7.0-curl

# Composer
RUN curl -sS https://getcomposer.org/installer | php --install-dir=/usr/local/bin --filename=composer \
