current_branch := $(shell git rev-parse --abbrev-ref HEAD)
DOCKER_NETWORK := docker-spark_default
ENV_FILE := ./hadoop-hive.env
build: 
	docker build -t bde2020/spark-base:$(current_branch) ./base
	docker build -t bde2020/spark-master:$(current_branch) ./master
	docker build -t bde2020/spark-worker:$(current_branch) ./worker
	docker build -t bde2020/spark-submit:$(current_branch) ./submit
	docker build -t bde2020/spark-example:$(current_branch) ./example-app

hdfs-test:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/spark-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/spark-base:$(current_branch) hdfs dfs -copyFromLocal /opt/hadoop-3.1.1/README.txt /input/	
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/spark-base:$(current_branch) /spark/bin/spark-submit --master spark://spark-master:7077 --class org.apache.spark.examples.HdfsTest /spark/examples/jars/spark-examples_2.11-2.3.2.jar /input/README.txt
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/spark-base:$(current_branch) hdfs dfs -rm -r /input
