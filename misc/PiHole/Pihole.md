# PiHole installation and setup

## Prerequisites
- raspberry pi has a static ip

## Install
`curl -sSL https://install.pi-hole.net | bash`

## Config
- set upstream dns to dns crypt proxy server: i.e. 192.168.1.12#53

## Blink indicator
- Install tools required as mentioned in pihole_status_blink.sh
- set it up and enable it as a service with status_blink.service
