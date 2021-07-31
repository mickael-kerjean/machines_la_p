FROM ubuntu:16.04
MAINTAINER mickael@kerjean.me

RUN apt-get update -y && \
    apt-get install -y curl unzip apache2 php php-mysql php-curl libapache2-mod-php php-cli php-mbstring php-xml php-sqlite3 php-ldap libssh2-1 php-ssh2 && \
    a2enmod rewrite && \
    a2enmod authnz_ldap && \
    sed -i 's|;extension=php_ldap|extension=php_ldap|' /etc/php/7.0/apache2/php.ini && \
    rm /var/www/html/index.html && \
    echo "<?php phpinfo(); ?>" > /var/www/html/index.php && \    
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD entrypoint.sh /
ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf
ENTRYPOINT ["bash", "/entrypoint.sh"]
WORKDIR "/var/www/html"
EXPOSE 80
