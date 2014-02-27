FROM centos
MAINTAINER Arata Fujimura

RUN echo 'LANG="ja_JP.UTF-8"' > /etc/sysconfig/i18n ;echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock ;cp -a /usr/share/zoneinfo/Asia/Tokyo /etc/localtime 

## FOr Web

# For EPEL
RUN cd /usr/local/src;wget http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm;rpm -ivh epel-release-6-8.noarch.rpm

# For Package
RUN yum groupinstall -y "Development Tools";yum --enablerepo=epel install -y zlib-devel openssl-devel libxml2-devel bzip2-devel curl-devel libpng-devel freetype-devel openldap-devel mysql-devel net-snmp-devel libxslt-devel libjpeg-devel libmcrypt-devel libevent-devel libmcrypt sudo libaio libaio-devel;

# For Apache
RUN cd /usr/local/src;wget http://www.us.apache.org/dist/httpd/httpd-2.2.26.tar.gz;tar -zxf httpd-2.2.26.tar.gz;cd httpd-2.2.26;./configure --prefix=/usr/local/apache2 --enable-so --enable-rewrite --enable-suexec --enable-module=all --enable-mods-shared=all --enable-cache=shared --enable-file-cache=shared --enable-mem-cache=shared --enable-disk-cache=shared --enable-proxy=shared --enable-ssl=shared --enable-cgi=shared --enable-cgid=shared --enable-passenger=shared;make;make install;

# For PHP
RUN cd /usr/local/src;wget http://www.php.net/get/php-5.3.28.tar.gz/from/jp1.php.net/mirror;tar -zxf php-5.3.28.tar.gz;cd php-5.3.28;./configure --with-pic --prefix=/usr/local/php --with-apxs2=/usr/local/apache2/bin/apxs --with-openssl=shared --with-mysql=/usr/bin '--with-mysqli=shared,/usr/bin/mysql_config' --with-curl --without-iconv --with-bz2 --with-zlib --enable-pcntl --enable-mbstring --enable-mbregex --with-gd --enable-gd-native-ttf --enable-gd-jis-conv --with-freetype-dir=/usr --with-zlib-dir=/usr --with-png-dir=/usr --with-jpeg-dir=/usr --with-libxml-dir=/usr --with-xmlrpc=shared --with-ldap=shared --with-ldap-sasl --with-snmp=/usr --enable-soap=shared '--with-xsl=shared,/usr' --enable-xmlreader=shared --enable-xmlwriter=shared --enable-sockets --enable-sysvshm --enable-dom --with-libdir=lib64 --enable-ltdl-install --with-mcrypt;make;make install;

# For Memcached
RUN cd /usr/local/src;wget http://memcached.googlecode.com/files/memcached-1.4.15.tar.gz;tar -zxf memcached-1.4.15.tar.gz;cd memcached-1.4.15;./configure --prefix=/usr/local/memcached --with-libevent=/usr/local/libevent;make;make install;cd /usr/local/php/bin;./pecl install memcache;


## For DB

# For create mysql user
RUN groupadd -g 600 mysql;useradd -g mysql -u 600 -d /home/mysql mysql;

# For OS Setup
# RUN echo -e "\n## For mysql direct-io\nvm.swappiness = 0\n" >> /etc/sysctl.conf;sysctl -p;
# RUN echo -e "\n## Thread Setting\nulimit -n 65535\n## end of Thread Setting\n" >> /etc/rc.d/rc;
# RUN echo -e "\nroot    soft    nofile  65535\nroot    hard    nofile  65535\n*       soft    nofile  65535\n*       hard    nofile  65535\n" >> /etc/security/limits.conf;
# RUN echo -e "\nsession    required     pam_limits.so\n" >> /etc/pam.d/login;

# For Percona Server Install
RUN cd /usr/local/src;wget http://www.percona.com/redir/downloads/Percona-Server-4.5/Percona-Server-5.5.29-29.4/binary/linux/x86_64/Percona-Server-5.5.29-rel29.4-401.Linux.x86_64.tar.gz;tar -zxf Percona-Server-5.5.29-rel29.4-401.Linux.x86_64.tar.gz;mkdir -p /var/xtradb/tmp;mkdir -p /var/xtradb/files/qualia;mkdir -p /var/xtradb/logs/qualia;mkdir -p /var/xtradb/qualia;mkdir -p /usr/local/xtradb;mkdir -p /etc/xtradb/qualia;mkdir -p /var/lib/mysql;mv /usr/local/src/Percona-Server-5.5.29-rel29.4-401.Linux.x86_64 /usr/local/xtradb/xtradb-5.5.29;chown -R mysql.mysql /var/xtradb /usr/local/xtradb /etc/xtradb /var/lib/mysql;

# For MySQL Config
ADD mysql_files/my.cnf /etc/xtradb/qualia/my.cnf
ADD mysql_files/mysql.conn /etc/xtradb/qualia/mysql.conn
ADD mysql_files/mysql.server /etc/xtradb/qualia/mysql.server

CMD cd /usr/local/xtradb/xtradb-5.5.29;sudo -u mysql ./scripts/mysql_install_db --datadir=/var/xtradb/qualia;
CMD sudo -u mysql /etc/xtradb/qualia/mysql.server start;

CMD /usr/local/apache2/bin/apachectl start;
