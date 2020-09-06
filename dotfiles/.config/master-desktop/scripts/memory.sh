#!/bin/bash

while true; do
    MEMORY=`free | grep Mem | awk '{print $3/$2 * 100.0}'`
    ~/.config/master-desktop/scripts/iconGrade.sh  "${MEMORY}"
    sleep 1
done