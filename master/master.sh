#!/bin/bash

/spark/sbin/start-master.sh

tail -f `find /spark/logs/ -name *Master*.out`
