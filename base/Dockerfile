FROM bde2020/hadoop-base:2.0.0-hadoop2.7.4-java8

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
      && wget https://www.dropbox.com/s/c09wigztyh1wsud/spark-1.6.3-bin-2.2.0.tgz \
      && apt-get --purge remove -y wget \
      && tar -xvzf spark-1.6.3-bin-2.2.0.tgz \
      && mv spark-1.6.3-bin-2.2.0 spark \
      && rm spark-1.6.3-bin-2.2.0.tgz \
      && cd /

ENV SPARK_HOME /spark/

COPY hive-site.xml /spark/conf/
COPY spark-env.sh /spark/conf/

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY statsd-jvm-profiler-2.1.0.jar /statsd-jvm-profiler.jar

ENTRYPOINT ["entrypoint.sh"]
