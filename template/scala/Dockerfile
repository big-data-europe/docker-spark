FROM bde2020/spark-submit:1.6.2-hadoop2.6

MAINTAINER Cecile Tonglet <cecile.tonglet@tenforce.com>

ENV SPARK_APPLICATION_JAR_NAME scala-2.11/app-assembly-0.1-SNAPSHOT
ENV SPARK_APPLICATION_MAIN_CLASS Application

COPY template.sh /

RUN chmod +x /template.sh \
      && update-java-alternatives -s java-1.8.0-openjdk-amd64 \
      && mkdir -p /app/project \
      && mkdir -p /usr/src/app/project

RUN apt-get-install apt-transport-https

RUN echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list \
      && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823

RUN apt-get-install sbt

ADD build.sbt /usr/src/app/
ADD plugins.sbt /usr/src/app/project/

# Pre-install base libraries
RUN cd /usr/src/app && sbt update

# Copy the build.sbt first, for separate dependency resolving and downloading
ONBUILD COPY build.sbt /usr/src/app/
ONBUILD COPY project /usr/src/app/project
ONBUILD RUN cd /usr/src/app && sbt update

# Copy the source code and build the application
ONBUILD COPY . /usr/src/app
ONBUILD RUN cd /usr/src/app && sbt clean assembly

CMD ["/bin/bash", "/template.sh"]
