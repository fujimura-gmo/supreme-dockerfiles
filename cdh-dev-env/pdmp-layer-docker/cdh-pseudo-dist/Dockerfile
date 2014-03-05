# cdh-pseudo-dist: installs pseudo distributed CDH4

FROM pdmp/oracle-jdk7

MAINTAINER "pdmp-gmo@gmo.jp"

# Cloudera CDH4 APT key and DPKG repositories
RUN apt-get -y install curl ;\
        curl -s http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh/archive.key | apt-key add -

RUN echo "deb [arch=amd64] http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh precise-cdh4 contrib\ndeb-src http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh precise-cdh4 contrib" > /etc/apt/sources.list.d/cloudera.list ;\
        cat /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y hadoop-0.20-conf-pseudo

RUN sudo -u hdfs hdfs namenode -format

RUN apt-get install -y supervisor
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Map Reduce ports
EXPOSE 8021 50030 9290 50060 50070

CMD ["/usr/bin/supervisord"]
