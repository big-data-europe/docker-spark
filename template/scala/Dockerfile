FROM bde2020/spark-submit:2.4.5-hadoop2.7

LABEL maintainer="Gezim Sejdiu <g.sejdiu@gmail.com>, Giannis Mouchakis <gmouchakis@gmail.com>"

ARG SBT_VERSION
ENV SBT_VERSION=${SBT_VERSION:-1.2.6}

RUN wget -O - https://piccolo.link/sbt-1.2.6.tgz | gunzip | tar -x -C /usr/local

ENV PATH /usr/local/sbt/bin:${PATH}

WORKDIR /app

# Pre-install base libraries
ADD build.sbt /app/
ADD plugins.sbt /app/project/
RUN sbt update

COPY template.sh /

ENV SPARK_APPLICATION_MAIN_CLASS Application

# Copy the build.sbt first, for separate dependency resolving and downloading
ONBUILD COPY build.sbt /app/
ONBUILD COPY project /app/project
ONBUILD RUN sbt update

# Copy the source code and build the application
ONBUILD COPY . /app
ONBUILD RUN sbt clean assembly

CMD ["/template.sh"]
