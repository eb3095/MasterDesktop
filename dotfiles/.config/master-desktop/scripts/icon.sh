#!/bin/bash

PROCESS=$1
ICON=$2
COLOR=$3
if [ -n "$COLOR" ]; then
    FOUND="%{F#${COLOR}}${ICON}"
else
    FOUND=${ICON}
fi

CHECK=`ps aux | grep ${PROCESS} | grep -v "grep" | grep -v "\.config" | wc -l`
if [ "$CHECK" != "0" ]; then
    echo ${FOUND}
else
    echo ${ICON}
fi