#!/bin/bash
# /opt/pihole_status_blink.sh
# install blink1-tool: https://github.com/todbot/blink1-tool/releases
# install bc : sudo apt-get install bc

while [ 1 ]; do
    loadavg=`uptime | awk '{print $10+0}'`

    if pihole status | grep ✗ > /dev/null; then
        blink1-tool -q --red -m 1000
    elif (( $(echo "$loadavg > 1" |bc -l) )); then
        /blink1-tool -q --red -m 1000
    elif (( $(echo "$loadavg > 0.8" |bc -l) )); then
        blink1-tool -q --yellow -m 1000
    else
        blink1-tool -q --green -m 1000
    fi
    sleep 2
    blink1-tool -q --off -m 1000
    sleep 2
done
