#!/bin/bash

function check_ico {
    CHECK=`i3-msg -t get_workspaces  | jq -c '.[] | select(.visible==true or .focused == true) | [.name]' | sed 's/"//g' | grep "\[${WORKSPACE}\]"`

    if [ -n "$CHECK" ]; then
        echo "%{F#fcba03}${ICON}"
    else
        echo "${ICON}"
    fi
}

function wait {
    while read i; do
        check_ico
    done < <(ncat -w 5 -k -l 127.0.0.1 -p $1)
}

WORKSPACE=$1
ICON=$2

if (( $WORKSPACE > 9 )); then
    PORT=620${WORKSPACE}
else
    PORT=6200${WORKSPACE}
fi

check_ico
wait $PORT