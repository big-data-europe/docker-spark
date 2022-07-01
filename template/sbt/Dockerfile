FROM bde2020/spark-submit:3.3.0-hadoop3.3

LABEL maintainer="Gezim Sejdiu <g.sejdiu@gmail.com>, Giannis Mouchakis <gmouchakis@gmail.com>"

ARG SBT_VERSION
ENV SBT_VERSION=${SBT_VERSION:-1.6.2}

RUN wget -O - https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz | gunzip | tar -x -C /usr/local

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
