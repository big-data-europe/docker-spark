FROM bde2020/spark-submit:2.4.4-hadoop2.7

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>
MAINTAINER Gezim Sejdiu <g.sejdiu@gmail.com>

ENV SPARK_APPLICATION_JAR_NAME application-1.0

COPY template.sh /

RUN apk add --no-cache openjdk8 maven\
      && chmod +x /template.sh \
      && mkdir -p /app \
      && mkdir -p /usr/src/app

# Copy the POM-file first, for separate dependency resolving and downloading
ONBUILD COPY pom.xml /usr/src/app
ONBUILD RUN cd /usr/src/app \
      && mvn dependency:resolve
ONBUILD RUN cd /usr/src/app \
      && mvn verify

# Copy the source code and build the application
ONBUILD COPY . /usr/src/app
ONBUILD RUN cd /usr/src/app \
      && mvn clean package

CMD ["/bin/bash", "/template.sh"]
