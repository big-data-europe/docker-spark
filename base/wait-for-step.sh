#!/bin/bash

echo "Validating if step ${INIT_DAEMON_STEP} can start in pipeline"
until [ $(curl -s $INIT_DAEMON_BASE_URI/canStart?step=$INIT_DAEMON_STEP) = "true" ]; do
    echo -n '.'
    sleep 5
done
