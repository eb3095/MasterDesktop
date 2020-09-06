#!/bin/bash

xdotool key $1

for ctr in {1..40}
do
    if (( $CTR > 9 )); then
        PORT=620${CTR}
    else
        PORT=6200${CTR}
    fi
   echo "PING" | netcat -c 127.0.0.1 ${PORT} &
done