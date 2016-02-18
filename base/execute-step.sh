#!/bin/bash

echo "Execute step ${INIT_DAEMON_STEP} in pipeline"
curl -X PUT $INIT_DAEMON_BASE_URI/execute?step=$INIT_DAEMON_STEP

