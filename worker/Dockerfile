FROM bde2020/spark-base:1.5.1-hadoop2.6

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>

ADD worker.sh /

EXPOSE 8081

CMD ["/bin/bash", "/worker.sh"]