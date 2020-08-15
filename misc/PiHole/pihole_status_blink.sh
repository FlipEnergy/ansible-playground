#!/bin/bash
# /opt/pihole_status_blink.sh
# install blink1-tool: https://github.com/todbot/blink1-tool/releases
# install bc : sudo apt-get install bc

blink1-tool -q --clearpattern
blink1-tool -q -m 1000 --red --setpattline 0
blink1-tool -q -m 1000 --off --setpattline 1
blink1-tool -q --savepattern


while [ 1 ]; do
    loadavg=`uptime | awk '{print $10+0}'`

    if pihole status | grep ✗ > /dev/null; then
        blink1-tool -q --magenta -m 1000
    elif (( $(echo "$loadavg > 0.8" |bc -l) )); then
        blink1-tool -q --yellow -m 1000
    fi
    blink1-tool -t 3000 --servertickle 1
    sleep 2
done
