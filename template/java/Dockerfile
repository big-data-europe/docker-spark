FROM bde2020/spark-submit:poc-init-daemon

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>

ENV SPARK_APPLICATION_JAR_NAME application-1.0

COPY template.sh /

RUN apt-get update \
      && apt-get install -y maven \
      && chmod +x /template.sh \
      && update-java-alternatives -s java-1.8.0-openjdk-amd64 \
      && mkdir -p /app \
      && mkdir -p /usr/src/app

ONBUILD COPY . /usr/src/app
ONBUILD RUN cd /usr/src/app \
      && mvn clean package

CMD ["/bin/bash", "/template.sh"]