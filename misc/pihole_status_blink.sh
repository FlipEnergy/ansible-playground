#!/bin/bash
while [ 1 ]; do
    if pihole status | grep ✗ > /dev/null; then
        /opt/blink1-tool/blink1-tool -q --red -m 1000
    else
        /opt/blink1-tool/blink1-tool -q --green -m 1000
    fi
    sleep 2
    /opt/blink1-tool/blink1-tool -q --off -m 1000
    sleep 2
done
