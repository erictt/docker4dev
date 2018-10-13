FROM debian:jessie-backports

MAINTAINER Eric Yang "ericyang879@gmail.com"

RUN apt-get update
RUN apt-get install -y apt-transport-https lsb-release ca-certificates wget
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
RUN apt-get update

ENV PHP_VERSION 7.1

# Install PHP-FPM
RUN apt-get install -t jessie-backports -y \
    php$PHP_VERSION \
    php$PHP_VERSION-fpm \
    php$PHP_VERSION-curl \
    php$PHP_VERSION-cli \
    php$PHP_VERSION-gd \
    php$PHP_VERSION-imagick \
    php$PHP_VERSION-json \
    php$PHP_VERSION-mcrypt \
    php$PHP_VERSION-mongo \
    php$PHP_VERSION-bcmath \
    php$PHP_VERSION-mysqlnd \
    php$PHP_VERSION-redis \
    php$PHP_VERSION-intl \
    php$PHP_VERSION-mbstring \
    php$PHP_VERSION-xdebug \
    php$PHP_VERSION-zip \
    php$PHP_VERSION-soap \
    php$PHP_VERSION-xml \
    php$PHP_VERSION-xmlrpc

# Php-fpm config
# RUN sed -i "s/;date.timezone =/date.timezone = Asia\/Shanghai/" /etc/php/$PHP_VERSION/fpm/php.ini
RUN sed -i "s/;date.timezone/date.timezone = America\/Toronto/" /etc/php/$PHP_VERSION/fpm/php.ini
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/$PHP_VERSION/fpm/php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 10M/g" /etc/php/$PHP_VERSION/fpm/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 10M/g" /etc/php/$PHP_VERSION/fpm/php.ini
RUN sed -i -e "s/memory_limit\s*=\s*128M/memory_limit = 512M/g" /etc/php/$PHP_VERSION/fpm/php.ini
RUN sed -i -e "s/max_execution_time\s*=\s*30/max_execution_time = 120/g" /etc/php/$PHP_VERSION/fpm/php.ini

# RUN sudo ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/timezone
# RUN sudo echo "Asia/Shanghai" > /etc/timezone
# RUN sudo dpkg-reconfigure -f noninteractive tzdata

# Add config files
RUN rm /etc/php/$PHP_VERSION/fpm/pool.d/www.conf
RUN rm /etc/php/$PHP_VERSION/fpm/php-fpm.conf

RUN ln -s /usr/sbin/php-fpm$PHP_VERSION /usr/sbin/php-fpm

ADD etc /etc/
# ADD config /config/

# VOLUME /data/logs/php /data/apps etc/php/$PHP_VERSION/fpm/pool.d
RUN mkdir -p /data/conf/php /data/logs/php

# --------------------- Add composer
RUN apt-get install -y curl git zip

# Setup the Composer installer
ENV PATH "/composer/vendor/bin:$PATH"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV COMPOSER_VERSION 1.7.2

RUN curl -s -f -L -o /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/da290238de6d63faace0343efbdd5aa9354332c5/web/installer \
 && php -r " \
    \$signature = '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410'; \
    \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
    if (!hash_equals(\$signature, \$hash)) { \
        unlink('/tmp/installer.php'); \
        echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
        exit(1); \
    }" \
 && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
 && rm /tmp/installer.php \
 && composer --ansi --version --no-interaction
# --------------------- /Add composer

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# Set up the volumes and working directory
# VOLUME /data/logs/php /data/apps
WORKDIR /data/apps

EXPOSE 9000

CMD ["/usr/sbin/php-fpm"]

