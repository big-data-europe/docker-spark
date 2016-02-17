FROM java:8

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>

ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

RUN apt-get update \
      && apt-get install -y curl \
      && chmod +x *.sh \
      && wget http://d3kbcqa49mib13.cloudfront.net/spark-1.5.1-bin-hadoop2.6.tgz \
      && tar -xvzf spark-1.5.1-bin-hadoop2.6.tgz \
      && mv spark-1.5.1-bin-hadoop2.6 spark 