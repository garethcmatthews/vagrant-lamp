
# LAMP Vagrant Application

A LAMP based Vagrant application for use in development.

### Applications
> Apache, PHP, curl, nano, composer  
> MySQL 8  
> phpMyadmin  

### PHP Versions
> PHP 7.4.33  
> PHP 8.0.30, 8.1.27, 8.2.15, PHP 8.3.2

### Setup
Copy the 'Vagrantfile' from the required PHP versions folder to the project root.

> Example  
> Copy ./resources/vagrant/php-8.3.2/Vagrantfile to ./  

### Vagrant

#### Running
> vagrant up

#### Reprovision Vagrant
> vagrant up --provision

#### Access vagrant box
> vagrant ssh

#### Browser
> http://localhost:8080

#### PHPmyadmin
> http://localhost:8080/phpmyadmin  
> Username root  
> Password: password  

