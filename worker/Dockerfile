FROM bde2020/spark-base:2.1.0-bigtop-java8

LABEL authors="Erika Pauwels <erika.pauwels@tenforce.com>, Gezim Sejdiu <g.sejdiu@gmail.com>, Cecile Tonglet <cecile.tonglet@tenforce.com>"

COPY worker.sh /

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /spark/logs
ENV SPARK_MASTER "spark://spark-master:7077"

EXPOSE 8081

CMD ["/worker.sh"]
