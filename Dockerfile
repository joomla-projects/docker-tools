FROM ubuntu:18.04

LABEL authors="Yves Hoppe, Robert Deutz"

# Install
RUN apt-get update \
  && DEBIAN_FRONTEND='noninteractive' apt-get -y install software-properties-common apt-transport-https language-pack-en-base \
  && LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php \
  && apt-get update \
	&& DEBIAN_FRONTEND='noninteractive' apt-get install -y --allow-unauthenticated \
    git vim curl mysql-client wget postgresql-client unzip build-essential \
    php7.2 php7.2-common php7.2-memcache php7.2-memcached php7.2-redis php-xdebug  \
    php7.2-gd php7.2-gettext php7.2-mbstring php7.2-mysql php7.2-sqlite3 \
    php7.2-pgsql php7.2-curl php7.2-ldap php7.2-zip php7.2-xml \
		&& sed -i 's/memory_limit\s*=.*/memory_limit=-1/g' /etc/php/7.2/cli/php.ini \
    && wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q > composer-setup.php \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=bin --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && curl -sL https://deb.nodesource.com/setup_12.x | /bin/sh - \ 
    && apt-get install -y nodejs \
    && npm install -g npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
