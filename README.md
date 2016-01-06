# Spark docker

Docker images to:
* Setup a standalone [Apache Spark](http://spark.apache.org/) cluster running one Spark Master and multiple Spark workers
* Build Spark applications in Java, Scala or Python to run on a Spark cluster

Currently supported versions:
* Spark 1.5.1 for Hadoop 2.6 and later

## Spark Master
To start a Spark master:

    docker run --name spark-master -h spark-master -d bde2020/spark-master:1.5.1-hadoop2.6

## Spark Worker
To start a Spark worker:

    docker run --name spark-worker-1 --link spark-master:spark-master -d bde2020/spark-worker:1.5.1-hadoop2.6

## Launch a Spark application
Building and running your Spark application on top of the Spark cluster is as simple as extending a template Docker image. Check the template's README for further documentation.
* [Java template](https://github.com/big-data-europe/docker-spark/tree/master/template/java)
* Scala template (will be added soon)
* Python template (will be added soon)
