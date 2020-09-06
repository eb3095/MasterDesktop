#!/bin/bash

while true; do
    CPU=`awk -v a="$(awk '/cpu /{print $2+$4,$2+$4+$5}' /proc/stat; sleep 1)" '/cpu /{split(a,b," "); print 100*($2+$4-b[1])/($2+$4+$5-b[2])}'  /proc/stat`
    ~/.config/master-desktop/scripts/iconGrade.sh  "${CPU}"
    sleep 1
done