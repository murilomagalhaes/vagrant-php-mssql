# Setup environment configuration
export ACCEPT_EULA="Y"
export MSSQL_PID="Developer"
export MSSQL_SA_PASSWORD="Mssql@vagrant"
export DEBIAN_FRONTEND="noninteractive"

# Update Packages
apt update

# Upgrade Packages
apt upgrade

# Install Git
apt install -y git

# Install Apache
apt install -y apache2

# Enable Apache Mods
a2enmod rewrite

# Install PHP
apt install -y php

# PHP Apache Mod
apt install -y libapache2-mod-php

# Restart Apache
service apache2 restart

# Install PHP Mods for working with most MVC frameworks
apt install -y php-common
apt install -y php-mcrypt
apt install -y php-zip
apt install -y php-dev
apt install -y php-json
apt install -y php-xml
apt install -y php-curl
apt install -y php-intl
apt install -y php-mbstring
apt install -y php-bcmath

# Install PHP Composer (Latest)
curl -Ss https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer

# Install NodeJS
apt install -y nodejs
apt install -y npm


###################################################
### MSSQL Server Installation #####################
### Special thanks to https://github.com/mloskot ##
###################################################


# Pre-installation
curl -s -S --retry 3 https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Repository Microsoft SQL Server 2019
add-apt-repository "$(curl -s -S --retry 3 https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list)"

# Repository SQL Server command-line tools
add-apt-repository "$(curl -s -S --retry 3 https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"

apt update

apt install -y mssql-server
apt install -y mssql-tools

# Post-installation
echo "SQLServer: running /opt/mssql/bin/mssql-conf -n setup"
echo "SQLServer: MSSQL_PID=$MSSQL_PID"
echo "SQLServer: MSSQL_SA_PASSWORD=$MSSQL_SA_PASSWORD"

sudo -E bash -c '/opt/mssql/bin/mssql-conf -n setup'
sudo /opt/mssql/bin/mssql-conf set telemetry.customerfeedback false

echo "SQLServer: restarting"
systemctl stop mssql-server
systemctl start mssql-server
systemctl status mssql-server

echo "SQLServer: adding /opt/mssql-tools/bin to PATH in ~/.bashrc and ~/.bash_profile"
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
export PATH="$PATH:/opt/mssql-tools/bin"

# Install Pre-requisites for MSSQL Server PHP Drivers
ACCEPT_EULA=Y apt-get install -y msodbcsql17
ACCEPT_EULA=Y apt-get install -y mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
apt install -y unixodbc-dev

# Install MSSQL Server PHP Drivers
pecl install sqlsrv
pecl install pdo_sqlsrv
printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.4/mods-available/sqlsrv.ini
printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.4/mods-available/pdo_sqlsrv.ini

phpenmod -v 7.4 sqlsrv pdo_sqlsrv

# Clean up
apt -y autoremove
apt -y clean
