# Image:     wishbone51/wordpress:1.0
# Author:    Wayne O'Neil - wayne@teamwishbone.com
# GitHub:    https://github.com/wishbone51/docker-wordpress
# DockerHub: https://hub.docker.com/r/wishbone51/wordpress

FROM php:7.4-apache-buster

# Install the mysqli plugin

RUN /usr/local/bin/docker-php-ext-install mysqli

# Download Wordpress

RUN /usr/bin/curl https://wordpress.org/wordpress-5.6.1.tar.gz | tar -xvz -C /var/www/html --strip-components 1

# patch PHP's entrypoint and add in my own stuff

COPY wishbone51-wordpress-entrypoint.patch /tmp/
RUN /usr/bin/patch -b /usr/local/bin/docker-php-entrypoint -i /tmp/wishbone51-wordpress-entrypoint.patch \
 && rm -f /tmp/wishbone51-wordpress-entrypoint.patch
