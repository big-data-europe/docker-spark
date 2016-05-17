# Spark docker

Docker images to:
* Setup a standalone [Apache Spark](http://spark.apache.org/) cluster running one Spark Master and multiple Spark workers
* Build Spark applications in Java, Scala or Python to run on a Spark cluster

Currently supported versions:
* Spark 1.5.1 for Hadoop 2.6 and later

## Using Docker Compose

Add the following services to your `docker-compose.yml` to integrate a Spark master and Spark worker in [your BDE pipeline](https://github.com/big-data-europe/app-bde-pipeline): 
```
master:
  image: bde2020/spark-master:1.5.1-hadoop2.6
  hostname: spark-master
  environment:
    INIT_DAEMON_STEP: setup_spark
worker:
  image: bde2020/spark-worker:1.5.1-hadoop2.6
  links:
    - "master:spark-master"
```
Make sure to fill in the `INIT_DAEMON_STEP` as configured in your pipeline.

## Running Docker containers without the init daemon
### Spark Master
To start a Spark master:

    docker run --name spark-master -h spark-master -e ENABLE_INIT_DAEMON=false -d bde2020/spark-master:1.5.1-hadoop2.6

### Spark Worker
To start a Spark worker:

    docker run --name spark-worker-1 --link spark-master:spark-master -e ENABLE_INIT_DAEMON=false -d bde2020/spark-worker:1.5.1-hadoop2.6
    
## Launch a Spark application
Building and running your Spark application on top of the Spark cluster is as simple as extending a template Docker image. Check the template's README for further documentation.
* [Java template](https://github.com/big-data-europe/docker-spark/tree/master/template/java)
* Scala template (will be added soon)
* Python template (will be added soon)
