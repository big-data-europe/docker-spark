[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/big-data-europe/Lobby)
# Spark docker

Docker images to:
* Setup a standalone [Apache Spark](http://spark.apache.org/) cluster running one Spark Master and multiple Spark workers
* Build Spark applications in Java, Scala or Python to run on a Spark cluster

Currently supported versions:
* Spark 2.3.0 for Hadoop 2.7+ with OpenJDK 8
* Spark 2.2.1 for Hadoop 2.7+ with OpenJDK 8
* Spark 2.2.0 for Hadoop 2.7+ with OpenJDK 8
* Spark 2.1.1 for Hadoop 2.7+ with OpenJDK 8
* Spark 2.1.0 for Hadoop 2.7+ with OpenJDK 8
* Spark 2.0.2 for Hadoop 2.7+ with OpenJDK 8
* Spark 2.0.1 for Hadoop 2.7+ with OpenJDK 8
* Spark 2.0.0 for Hadoop 2.7+ with Hive support and OpenJDK 8
* Spark 2.0.0 for Hadoop 2.7+ with Hive support and OpenJDK 7
* Spark 1.6.2 for Hadoop 2.6 and later
* Spark 1.5.1 for Hadoop 2.6 and later

## Using Docker Compose

Add the following services to your `docker-compose.yml` to integrate a Spark master and Spark worker in [your BDE pipeline](https://github.com/big-data-europe/app-bde-pipeline):
```yml
spark-master:
  image: bde2020/spark-master:2.3.0-hadoop2.7
  container_name: spark-master
  ports:
    - "8080:8080"
    - "7077:7077"
  environment:
    - INIT_DAEMON_STEP=setup_spark
    - "constraint:node==<yourmasternode>"
spark-worker-1:
  image: bde2020/spark-worker:2.3.0-hadoop2.7
  container_name: spark-worker-1
  depends_on:
    - spark-master
  ports:
    - "8081:8081"
  environment:
    - "SPARK_MASTER=spark://spark-master:7077"
    - "constraint:node==<yourmasternode>"
spark-worker-2:
  image: bde2020/spark-worker:2.3.0-hadoop2.7
  container_name: spark-worker-2
  depends_on:
    - spark-master
  ports:
    - "8081:8081"
  environment:
    - "SPARK_MASTER=spark://spark-master:7077"
    - "constraint:node==<yourworkernode>"  
```
Make sure to fill in the `INIT_DAEMON_STEP` as configured in your pipeline.

## Running Docker containers without the init daemon
### Spark Master
To start a Spark master:

    docker run --name spark-master -h spark-master -e ENABLE_INIT_DAEMON=false -d bde2020/spark-master:2.3.0-hadoop2.7

### Spark Worker
To start a Spark worker:

    docker run --name spark-worker-1 --link spark-master:spark-master -e ENABLE_INIT_DAEMON=false -d bde2020/spark-worker:2.3.0-hadoop2.7

## Launch a Spark application
Building and running your Spark application on top of the Spark cluster is as simple as extending a template Docker image. Check the template's README for further documentation.
* [Java template](https://github.com/big-data-europe/docker-spark/tree/master/template/java)
* [Python template](https://github.com/big-data-europe/docker-spark/tree/master/template/python)
* Scala template (will be added soon)
