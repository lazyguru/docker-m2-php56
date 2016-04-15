FROM lazyguru/mage2base

# Installing PHP 5.6
RUN yum -y install https://mirror.webtatic.com/yum/el6/latest.rpm
RUN yum -y install php56w-pecl-memcache php56w-fpm php56w-intl php56w-mcrypt php56w-mbstring php56w-mysql php56w-pdo php56w-mbstring php56w-soap php56w-pecl-zendopcache php56w-xml php56w-gd php56w-opcache php56w-pecl-imagick php56w-bcmath
# <---- End

# php
ADD etc/php.conf/php.ini /etc/php.ini

# php fpm
RUN mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.default
ADD etc/php-fpm.conf/www.conf /etc/php-fpm.d/www.conf
RUN mkdir -p /var/lib/php/session
RUN mkdir -p /var/lib/php/wsdlcache
RUN chmod -R 777 /var/lib/php/session
RUN chmod -R 777 /var/lib/php/wsdlcache

VOLUME ["/var/www/html"]

EXPOSE 9001

ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

CMD ["/bin/bash", "/start.sh"]
