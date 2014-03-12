# mission-app
FROM mission-app
MAINTAINER Naohisa Orita

#EXPOSE 80
ENTRYPOINT \
  service haproxy start \
  ;sed -i "s/web245/$HOSTNAME/" /etc/td-agent/td-agent.conf \
  ;service td-agent start \
  ;service httpd start \
  ;/bin/bash
