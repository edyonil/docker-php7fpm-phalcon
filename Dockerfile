FROM php:7.0-fpm
MAINTAINER Edyonil <edyonil>

ENV PHALCON_VERSION=3.2.2

ENV DEBIAN_FRONTEND noninteractive

# Dependencies
RUN apt-get update
RUN apt-get install -y libpcre3-dev gcc make re2c git-core

# Compile Phalcon
RUN git clone https://github.com/phalcon/cphalcon.git
RUN cd cphalcon/ &&  git checkout tags/v${PHALCON_VERSION}
RUN cd cphalcon/build && ./install
RUN echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini
RUN cd ../ && rm -rf cphalcon/

# PHP Extensions
RUN apt-get update
RUN apt-get install -y --force-yes php7.0-mysql php7.0-xml php7.0-mbstring php7.0-mcrypt php7.0-zip php7.0-curl

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer