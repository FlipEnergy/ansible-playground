#!/bin/bash
# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'


trap ctrl_c INT

function ctrl_c() {
    echo -e ${NOCOLOR}
    exit 0
}

while [ 1 ]; do
    clear
    echo -e ${YELLOW}
    echo =========================================================================================
    echo CPU
    echo =========================================================================================
    echo -e ${LIGHTBLUE}
    kubectl top pod -A --sort-by=cpu
    echo -e ${YELLOW}
    echo =========================================================================================
    echo MEMORY
    echo =========================================================================================
    echo -e ${LIGHTGREEN}
    kubectl top pod -A --sort-by=memory
    echo -e ${YELLOW}
    echo =========================================================================================
    echo NODES
    echo =========================================================================================
    echo -e ${LIGHTPURPLE}
    kubectl top nodes
    echo -e ${NOCOLOR}
    sleep 30
done
