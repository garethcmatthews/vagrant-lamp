#!/bin/bash

# Settings
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-mysql}
PHP_VERSION=${PHP_VERSION:-7.4}

# System
export DEBIAN_FRONTEND="noninteractive"
apt-get update
apt-get upgrade --yes
add-apt-repository ppa:ondrej/php
apt-get update
apt-get install --no-install-recommends --yes nano
apt-get install --no-install-recommends --yes libzip-dev
apt-get install --no-install-recommends --yes unzip

# Install MySQL
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
apt-get install --no-install-recommends --yes mysql-server

# Apache
apt-get install --no-install-recommends --yes apache2
a2enmod rewrite
mv /home/vagrant/000-default.conf /etc/apache2/sites-available
rm -f /var/www/html/index.html

# PHP
apt-get install --no-install-recommends --yes libapache2-mod-php$PHP_VERSION
apt-get install --no-install-recommends --yes php$PHP_VERSION
apt-get install --no-install-recommends --yes php$PHP_VERSION-cli
apt-get install --no-install-recommends --yes php$PHP_VERSION-mbstring
apt-get install --no-install-recommends --yes php$PHP_VERSION-mysqli
apt-get install --no-install-recommends --yes zip$PHP_VERSION
sed -i "s|^;date.timezone =.*$|date.timezone = Europe/London|" /etc/php/$PHP_VERSION/apache2/php.ini
sed -i "s|display_startup_errors =.*$|display_startup_errors = On|" /etc/php/$PHP_VERSION/apache2/php.ini
sed -i "s|display_errors =.*$|display_errors = On|" /etc/php/$PHP_VERSION/apache2/php.ini
sed -i "s|^;error_log =.*$|error_log = /var/log/php/php-error.log|" /etc/php/$PHP_VERSION/apache2/php.ini

# phpMyAdmin
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
apt-get install --no-install-recommends --yes phpmyadmin

# Composer
RUN cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php && \
php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Start Services
systemctl restart apache2
