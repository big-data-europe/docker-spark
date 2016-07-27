FROM java:8

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

COPY bde-spark.css /css/org/apache/spark/ui/static/timeline-view.css

RUN apt-get update \
      && apt-get install -y curl \
      && chmod +x *.sh \
      && wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.2-bin-hadoop2.6.tgz \
      && tar -xvzf spark-1.6.2-bin-hadoop2.6.tgz \
      && mv spark-1.6.2-bin-hadoop2.6 spark \
      && rm spark-1.6.2-bin-hadoop2.6.tgz \
      && cd /css \
      && jar uf /spark/lib/spark-assembly-1.6.2-hadoop2.6.0.jar org/apache/spark/ui/static/timeline-view.css \
      && cd /
