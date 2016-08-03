FROM bde2020/spark-base:1.6.2-hadoop2.6

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>

ENV SPARQL_ENDPOINT 'http://database:8890/sparql'

ENV SPARK_MASTER_NAME spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_APPLICATION_JAR_LOCATION /app/application.jar
ENV SPARK_APPLICATION_MAIN_CLASS my.main.Application
ENV SPARK_APPLICATION_ARGS ""

RUN apt-get update \
      && apt-get install -y ruby \
      && gem install rdf rdf-vocab sparql-client

COPY submit.sh spark-submit.sh job-execution.rb /

CMD ["/bin/bash", "/submit.sh"]
