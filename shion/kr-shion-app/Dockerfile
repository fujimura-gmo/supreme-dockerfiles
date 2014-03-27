# shion-app
#FROM shion-app
FROM shion-app
MAINTAINER Naohisa Orita

ENV APP_DOMAIN shion-kr.com

RUN mkdir /var/log/httpd/{avt.$APP_DOMAIN,img.$APP_DOMAIN,$APP_DOMAIN}
RUN mkdir /var/www/$APP_DOMAIN
RUN ln -s /var/www/$APP_DOMAIN/current /var/www/shion
ADD vhost-shion.conf /etc/httpd/conf.d/

#EXPOSE 80
ENTRYPOINT \
  sed -i "s/web245/$HOSTNAME/" /etc/td-agent/td-agent.conf \
  ;service td-agent start \
  ;service serf start \
  ;service haproxy start \
  ;service httpd start \
  ;/bin/bash
