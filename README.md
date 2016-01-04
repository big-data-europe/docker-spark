# Spark docker

Docker for setting up a standalone [Apache Spark](http://spark.apache.org/) cluster running one Spark Master and multiple Spark workers.

Currently supported versions:
- Spark 1.5.1 for Hadoop 2.6 and later

## Spark Master
To start a Spark master:

    docker run --name spark-master -h spark-master -d bde2020/spark-master:1.5.1-hadoop2.6

## Spark Worker
To start a Spark worker:

    docker run --name spark-worker-1 --link spark-master:spark-master -d bde2020/spark-worker:1.5.1-hadoop2.6

## Launch a Spark application using Spark submit
Package your Spark application including dependency JARs except Spark JARs which will already be available on the worker nodes. You can submit the application to the Spark cluster by extending the Spark submit image or by directly submitting the application using the Spark submit image. 

### Extending the Spark submit image with your application

#### Steps to extend the Spark submit image
1. Extend the Spark submit Docker image
2. Configure the following environment variables:
  * `SPARK_MASTER_NAME` (default: spark-master)
  * `SPARK_MASTER_PORT` (default: 7077)
  * `SPARK_APPLICATION_JAR` (default: /app/application.jar)
  * `SPARK_APPLICATION_MAIN_CLASS` (default: my.main.Application)
  * `SPARK_APPLICATION_ARGS` (default: "")
3. Add the application JAR to the `SPARK_APPLICATION_JAR` location.
4. Build and run the image
```
docker build --rm=true -t spark-app .
docker run --name my-spark-app --link spark-master:spark-master -d spark-app
```

#### Example Dockerfile
```
FROM bde2020/spark-submit:1.5.1-hadoop2.6

MAINTAINER Erika Pauwels <erika.pauwels@tenforce.com>

ENV SPARK_APPLICATION_MAIN_CLASS my.main.Application
ENV SPARK_APPLICATION_ARGS "foo bar baz"

ADD myCustomApplicationWithDependencies.jar /app/application.jar
```

#### Example application
See [big-data-europe/demo-spark-sensor-data](https://github.com/big-data-europe/demo-spark-sensor-data).

### Submitting your application directly to the Spark cluster

    docker run --name spark-submit \
        --link spark-master:spark-master \
        --volume /path/to/your/my-application.jar:/app/application.jar \
        -e SPARK_APPLICATION_MAIN_CLASS="my.main.Application" \
        -e SPARK_APPLICATION_ARGS="{application-arguments}"
        -d bde2020/spark-submit:1.5.1-hadoop2.6
        
To change the default Spark master URL (`spark://spark-master:7077`), overwrite the `SPARK_MASTER_NAME` and `SPARK_MASTER_PORT` environment variables.

To configure the location of the application JAR, overwrite the `SPARK_APPLICATION_JAR` environment variable. Don't forget to update the mounted volume accordingly.
