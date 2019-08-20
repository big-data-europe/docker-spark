#!/bin/bash

export SPARK_MASTER_URL=spark://${SPARK_MASTER_NAME}:${SPARK_MASTER_PORT}
export SPARK_HOME=/spark

function is_uri() {
    regex='(https?|hdfs|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $1 =~ $regex ]]
    then 
        echo "true"
    else
        echo "false"
    fi
}


/wait-for-step.sh


/execute-step.sh
if [[ `is_uri $SPARK_APPLICATION_JAR_LOCATION`=="true" || -f "${SPARK_APPLICATION_JAR_LOCATION}" ]]; then
    echo "Submit application ${SPARK_APPLICATION_JAR_LOCATION} with main class ${SPARK_APPLICATION_MAIN_CLASS} to Spark master ${SPARK_MASTER_URL}"
    echo "Passing arguments ${SPARK_APPLICATION_ARGS}"
    # Uses eval so that parameters in quotes could be passed, relevant for --conf parameters
    $(eval /spark/bin/spark-submit \
        --class ${SPARK_APPLICATION_MAIN_CLASS} \
        --master ${SPARK_MASTER_URL} \
        ${SPARK_SUBMIT_ARGS} \
        ${SPARK_APPLICATION_JAR_LOCATION} ${SPARK_APPLICATION_ARGS})
else
    if [[ `is_uri $SPARK_APPLICATION_PYTHON_LOCATION`=="true" || -f "${SPARK_APPLICATION_PYTHON_LOCATION}" ]]; then
        echo "Submit application ${SPARK_APPLICATION_PYTHON_LOCATION} to Spark master ${SPARK_MASTER_URL}"
        echo "Passing arguments ${SPARK_APPLICATION_ARGS}"
        PYSPARK_PYTHON=python3  /spark/bin/spark-submit \
            --master ${SPARK_MASTER_URL} \
            ${SPARK_SUBMIT_ARGS} \
            ${SPARK_APPLICATION_PYTHON_LOCATION} ${SPARK_APPLICATION_ARGS}
    else
        echo "Not recognized application."
    fi
fi
/finish-step.sh
