#!/bin/bash

NGINX_STATUS_URL=http://localhost:9090/nginx_status

INTERVAL=5
TRANSITION_MS=1000

alias blink='blink1-tool -q'

blink --servertickle 0
blink --clearpattern
blink --random=5
blink --off

while true; do
    NGINX_STATUS=$(curl $NGINX_STATUS_URL)
    if [[ $? -ne 0 ]]; then
        blink --blink --white -m $TRANSITION_MS
        sleep $INTERVAL
        continue
    fi

    ACTIVE_CONNECTIONS=$(echo $NGINX_STATUS | grep 'Active connections:' | awk '{print $3}')

    if [[ $ACTIVE_CONNECTIONS -gt 1000 ]]; then
        blink --blink --rgb FF0000 -m $TRANSITION_MS
    elif [[ $ACTIVE_CONNECTIONS -gt 500 ]]; then
        blink --blink --rgb FF8000 -m $TRANSITION_MS
    elif [[ $ACTIVE_CONNECTIONS -gt 100 ]]; then
        blink --blink --rgb FFFF00 -m $TRANSITION_MS
    elif [[ $ACTIVE_CONNECTIONS -gt 10 ]]; then
        blink --blink --rgb 00FF00 -m $TRANSITION_MS
    fi
    sleep $INTERVAL
done
