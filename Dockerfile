# wishbone/wordpress
#
# VERSION               php-7.4-apache-buster-wordpress-5.6.1-1.1

FROM php:7.4-apache-buster
COPY wishbone-wordpress-entrypoint /tmp/
RUN sed -i -e '/set -e/r /tmp/wishbone-wordpress-entrypoint' /usr/local/bin/docker-php-entrypoint \
 && rm -f /tmp/wishbone-wordpress-entrypoint \
 && /usr/local/bin/docker-php-ext-install mysqli \
 && /usr/bin/curl https://wordpress.org/wordpress-5.6.1.tar.gz | tar -xvz -C /var/www/html --strip-components 1
