#!/bin/bash

export SPARK_HOME=/spark

. "/spark/sbin/spark-config.sh"

. "/spark/bin/load-spark-env.sh"

SPARK_HS_LOG_DIR=$SPARK_HOME/spark-hs-logs

mkdir -p $SPARK_HS_LOG_DIR

LOG=$SPARK_HS_LOG_DIR/spark-hs.out

ln -sf /dev/stdout $LOG

# See https://spark.apache.org/docs/latest/monitoring.html#environment-variables
export SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory=/tmp/spark-events -Dspark.history.ui.port=18081"

cd /spark/bin && /spark/sbin/../bin/spark-class org.apache.spark.deploy.history.HistoryServer >> $LOG
