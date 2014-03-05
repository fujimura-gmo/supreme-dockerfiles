# oracle-jdk7: installs python setup tools (specifically for add-apt-repository used below) and oracle jdk7

FROM ubuntu:12.04

MAINTAINER "pdmp-gmo@gmo.jp"

RUN apt-get update
RUN apt-get -y install python-software-properties python-setuptools

RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update

RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java7-installer && apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV HADOOP_LIBEXEC_DIR /usr/lib/hadoop/libexec

