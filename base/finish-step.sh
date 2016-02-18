#!/bin/bash

echo "Execute step ${INIT_DAEMON_STEP} in pipeline"
while true; do
    sleep 5
    echo -n '.'
    string=$(curl -sL -w "%{http_code}" -X PUT $INIT_DAEMON_BASE_URI/finish?step=$INIT_DAEMON_STEP -o /dev/null)
    [ "$string" = "204" ] && break
done



