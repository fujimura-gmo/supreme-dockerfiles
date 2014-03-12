FROM centos
MAINTAINER Naohisa Orita

RUN echo 'LANG="ja_JP.UTF-8"' > /etc/sysconfig/i18n \
  ;echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock \
  ;cp -a /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  ;rpm -ivh http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/i386/epel-release-6-8.noarch.rpm \
  ;yum -y install npm git redis \
  ;npm install hipache -g \
  ;mkdir /etc/hipache/ \
  ;yum clean all
ADD ./hipache_config.json /etc/hipache/hipache_config.json
RUN sed -i 's/^bind 127.0.0.1/bind 0.0.0.0/' /etc/redis.conf

EXPOSE 80
EXPOSE 6379
ENTRYPOINT service redis start;hipache -c /etc/hipache/hipache_config.json
