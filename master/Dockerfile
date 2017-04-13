FROM bde2020/spark-base:2.1.0-hadoop2.7

LABEL authors="Erika Pauwels <erika.pauwels@tenforce.com>, Gezim Sejdiu <g.sejdiu@gmail.com>, Cecile Tonglet <cecile.tonglet@tenforce.com>"

COPY master.sh /

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /spark/logs

EXPOSE 8080 7077 6066

CMD ["/master.sh"]
