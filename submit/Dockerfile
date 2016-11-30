FROM bde2020/spark-base:2.0.0-hadoop2.7-hive-java8

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>
MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

ENV SPARK_MASTER_NAME spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_APPLICATION_JAR_LOCATION /app/application.jar
ENV SPARK_APPLICATION_MAIN_CLASS my.main.Application
ENV SPARK_APPLICATION_ARGS ""

COPY submit.sh /

CMD ["/bin/bash", "/submit.sh"]
