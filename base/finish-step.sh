#!/bin/bash

echo "Finish step ${INIT_DAEMON_STEP} in pipeline"
until [ $(curl -s -X PUT $INIT_DAEMON_BASE_URI/finish?step=$INIT_DAEMON_STEP) = "true" ]; do
    echo -n '.'
    sleep 5
done
