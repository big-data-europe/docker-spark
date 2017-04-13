FROM openjdk:8

LABEL authors="Erika Pauwels <erika.pauwels@tenforce.com>, Gezim Sejdiu <g.sejdiu@gmail.com>, Cecile Tonglet <cecile.tonglet@tenforce.com>"

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV SPARK_VERSION=2.1.0
ENV HADOOP_VERSION=2.7.3
ENV BIGTOP_VERSION=1.2.0

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

COPY bde-spark.css /css/org/apache/spark/ui/static/timeline-view.css

ADD https://raw.githubusercontent.com/guilhem/apt-get-install/master/apt-get-install /usr/bin/
RUN chmod +x /usr/bin/apt-get-install

RUN apt-get-install curl

ADD https://www.apache.org/dist/bigtop/bigtop-${BIGTOP_VERSION}/repos/debian8/bigtop.list /etc/apt/sources.list.d/
RUN curl https://www.apache.org/dist/bigtop/bigtop-${BIGTOP_VERSION}/repos/GPG-KEY-bigtop | apt-key add -

RUN apt-get-install spark-core

RUN (cd /css && jar uf /usr/lib/spark/jars/spark-core_2.11-${SPARK_VERSION}.jar org/apache/spark/ui/static/timeline-view.css) \
      && rm -fR /css \
      && ln -s /usr/lib/spark /spark

RUN apt-get-install -y python3 python3-setuptools python3-pip

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1
