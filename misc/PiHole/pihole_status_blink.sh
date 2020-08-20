#!/bin/bash
# /opt/pihole_status_blink.sh
# install blink1-tool: https://github.com/todbot/blink1-tool/releases
# install bc : sudo apt-get install bc

blink1-tool --servertickle 0

blink1-tool -q --clearpattern
blink1-tool -q -m 2000 --red --setpattline 0
blink1-tool -q -m 2000 --off --setpattline 1
blink1-tool -q --savepattern

# Startup light
for h in {0..15}; do
    ((hue=h*16))
    blink1-tool -l 2 --hsb $hue,255,255
    blink1-tool -l 1 --hsb $hue_old,255,255
    hue_old=$hue
    sleep 0.1
done

while [ 1 ]; do
    loadavg=`uptime | awk '{print $10+0}'`

    if pihole status | grep ✗ > /dev/null; then
        blink1-tool -q --magenta -m 1000
        blink1-tool -q --off -m 1000
    elif (( $(echo "$loadavg > 0.8" |bc -l) )); then
        blink1-tool -q --yellow -m 1000
        blink1-tool -q --off -m 1000
    fi
    sleep 2
    blink1-tool -t 5000 --servertickle 1
done
