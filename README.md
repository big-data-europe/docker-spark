# Spark docker

Docker images to:
* Setup a standalone [Apache Spark](http://spark.apache.org/) cluster running one Spark Master and multiple Spark workers
* Build Spark applications in Java, Scala or Python to run on a Spark cluster

### Example Application

1. Run the cluster
```
make network
make spark
```

2. Run the application (calculates Pi)
```
make spark-app
```

3. Stop & clean up
```
make down
```
