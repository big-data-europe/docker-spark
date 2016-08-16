#!/bin/bash

export SPARK_MASTER_IP=`hostname`

. "/spark/sbin/spark-config.sh"

. "/spark/bin/load-spark-env.sh"

mkdir -p $SPARK_MASTER_LOG

/spark/bin/spark-class org.apache.spark.deploy.master.Master \
    --host $SPARK_MASTER_IP --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >> $SPARK_MASTER_LOG/spark-master.out
