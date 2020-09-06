#!/bin/bash

DATA="${DATA}  <b>Public IP</b>: `curl ifconfig.me`\n"
notify-send "Network" "${DATA}"

for iface in $(ifconfig | cut -d ' ' -f1| tr ':' '\n' | awk NF)
do
    if [ "${iface}" == "lo" ]; then
        continue
    fi

    if [ `cat /sys/class/net/${iface}/operstate` != "up" ]; then
        continue
    fi

    if [ `ethtool -P ${iface} | tail -n 1 | awk -F' ' '{print $3}'` == "00:00:00:00:00:00" ]; then
        continue
    fi

    DATA="\n"
    DATA="${DATA}  <b>MAC</b>: `ifconfig ${iface} | grep "ether" | awk -F' ' '{print $2}'`\n"
    DATA="${DATA}  <b>IP</b>: `ifconfig ${iface} | grep -v "inet6" | grep "inet" | awk -F' ' '{print $2}'`\n"
    DATA="${DATA}  <b>IPv6</b>: `ifconfig ${iface} | grep "inet6" | awk -F' ' '{print $2}'`\n"
    DATA="${DATA}  <b>Speed</b>: `ethtool ${iface} | grep Speed | awk -F' ' '{print $2}'`"

    notify-send "Network: ${iface}" "${DATA}"
done