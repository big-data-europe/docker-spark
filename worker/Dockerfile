FROM bde2020/spark-base:poc-init-daemon

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>

COPY worker.sh /

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /spark/logs
ENV SPARK_MASTER "spark://spark-master:7077"

EXPOSE 8081

CMD ["/bin/bash", "/worker.sh"]