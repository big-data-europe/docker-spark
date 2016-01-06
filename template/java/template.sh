#!/bin/bash

cd /usr/src/app
mvn clean package
cp target/${SPARK_APPLICATION_JAR_NAME}.jar ${SPARK_APPLICATION_JAR_LOCATION}

sh /submit.sh
