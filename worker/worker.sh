#!/bin/bash

/spark/sbin/start-slave.sh spark://spark-master:7077

tail -f `find /spark/logs/ -name *Worker*.out`
