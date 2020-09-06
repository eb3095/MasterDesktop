#!/bin/bash

INTERFACE=$1

DATA="\n"
DATA="${DATA}  <b>MAC</b>: `ifconfig ${INTERFACE} | grep "ether" | awk -F' ' '{print $2}'`\n"
DATA="${DATA}  <b>IP</b>: `ifconfig ${INTERFACE} | grep -v "inet6" | grep "inet" | awk -F' ' '{print $2}'`\n"
DATA="${DATA}  <b>IPv6</b>: `ifconfig ${INTERFACE} | grep "inet6" | awk -F' ' '{print $2}'`\n"
DATA="${DATA}  <b>Speed</b>: `ethtool ${INTERFACE} | grep Speed | awk -F' ' '{print $2}'`"

notify-send "Network: ${INTERFACE}" "${DATA}"
