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
Package your Spark application including dependency JARs except Spark JARs which will already be available on the worker nodes. Submit the application to the Spark cluster:

    docker run --name spark-submit \
        --link spark-master:spark-master \
        --volume /path/to/your/my-application.jar:/app/application.jar \
        -d bde2020/spark-submit:1.5.1-hadoop2.6 \
            --class my.main.Application \
            --master spark://spark-master:7077 \
            /app/application.jar {application-arguments}
