#!/bin/bash

ICON=$1
VALUE=`printf "%.0f" $2`

COLOR="%{F#47ff53}"
COLOR2="%{F#b8ff47}"
COLOR3="%{F#fcff47}"
COLOR4="%{F#ffbc47}"
COLOR5="%{F#ff4747}"

if [ "${VALUE}" -gt 25 ]; then
    COLOR=${COLOR2}
fi

if [ "${VALUE}" -gt 50 ]; then
    COLOR=${COLOR3}
fi

if [ "${VALUE}" -gt 75 ]; then
    COLOR=${COLOR4}
fi

if [ "${VALUE}" -gt 90 ]; then
    COLOR=${COLOR5}
fi

echo " ${COLOR}${ICON}"