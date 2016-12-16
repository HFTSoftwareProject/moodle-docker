# Dockerfile for moodle instance. more dockerish version of https://github.com/sergiogomez/docker-moodle
# Forked from Jon Auer's docker version. https://github.com/jda/docker-moodle
FROM ubuntu:16.04
MAINTAINER Jonathan Hardison <jmh@jonathanhardison.com>
#Original Maintainer Jon Auer <jda@coldshore.com>

#Proxy
ENV http_proxy 'http://proxy.hft-stuttgart.de:80'
ENV https_proxy 'http://proxy.hft-stuttgart.de:80'

VOLUME ["/var/moodledata"]
EXPOSE 80 443
COPY moodle-config.php /var/www/html/config.php

# Keep upstart from complaining
# RUN dpkg-divert --local --rename --add /sbin/initctl
# RUN ln -sf /bin/true /sbin/initctl

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Database info
#ENV MYSQL_HOST 127.0.0.1
#ENV MYSQL_USER moodle
#ENV MYSQL_PASSWORD moodle
#ENV MYSQL_DB moodle
ENV MOODLE_URL http://10.40.10.5

ADD ./foreground.sh /etc/apache2/foreground.sh

RUN apt-get update && \
	apt-get -y install mysql-client pwgen python-setuptools curl git unzip apache2 php \
		php-gd libapache2-mod-php postfix wget supervisor php-pgsql curl libcurl3 \
		libcurl3-dev php-curl php-xmlrpc php-intl php-mysql git-core php-xml php-mbstring php-zip php-soap && \
	cd /tmp && \
	git clone -b MOODLE_31_STABLE https://github.com/moodle/moodle.git --depth=1 && \
	mv /tmp/moodle/* /var/www/html/ && \
	rm /var/www/html/index.html && \

	chown -R www-data:www-data /var/www/html && \
	chmod +x /etc/apache2/foreground.sh

RUN git clone https://github.com/HFTSoftwareProject/moodle-assignsubmission_mojec.git /var/www/html/mod/assign/submission/mojec
			
# Enable SSL, moodle requires it
# RUN a2enmod ssl && a2ensite default-ssl # if using proxy, don't need actually secure connection

# Cleanup
RUN apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/lib/dpkg/* /var/lib/cache/* /var/lib/log/*


CMD ["/etc/apache2/foreground.sh"]

# RUN easy_install supervisor
# ADD ./start.sh /start.sh
# ADD ./supervisord.conf /etc/supervisord.conf
# RUN chmod 755 /start.sh /etc/apache2/foreground.sh
# EXPOSE 22 80
# CMD ["/bin/bash", "/start.sh"]
