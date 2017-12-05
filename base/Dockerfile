FROM bde2020/hadoop-base:1.1.0-hadoop2.8-java8

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>
MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

RUN apt-get update \
      && apt-get install -y wget \
      && wget https://www.dropbox.com/s/mgb6h7cwkbzct6f/spark-2.2.0-bin-2.8.2.tgz \
      && apt-get --purge remove -y wget \
      && tar -xvzf spark-2.2.0-bin-2.8.2.tgz \
      && mv spark-2.2.0-bin-2.8.2 spark \
      && rm spark-2.2.0-bin-2.8.2.tgz \
      && cd /

ENV SPARK_HOME /spark/

COPY hive-site.xml /spark/conf/

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
