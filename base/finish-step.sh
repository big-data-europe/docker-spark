#!/bin/bash

echo "Finish step ${INIT_DAEMON_STEP} in pipeline"
curl -s -X PUT $INIT_DAEMON_BASE_URI/finish?step=$INIT_DAEMON_STEP
