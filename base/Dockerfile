FROM bde2020/hadoop-base:2.0.0-hadoop3.1.1-java8

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
      && wget https://archive.apache.org/dist/spark/spark-2.3.2/spark-2.3.2-bin-without-hadoop.tgz \
      && apt-get --purge remove -y wget \
      && tar -xvzf spark-2.3.2-bin-without-hadoop.tgz \
      && mv spark-2.3.2-bin-without-hadoop spark \
      && rm spark-2.3.2-bin-without-hadoop.tgz \
      && cd /

ENV SPARK_HOME /spark/

COPY hive-site.xml /spark/conf/
COPY spark-env.sh /spark/conf/

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY statsd-jvm-profiler-2.1.0.jar /statsd-jvm-profiler.jar

ENTRYPOINT ["entrypoint.sh"]
