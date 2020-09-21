#!/bin/bash

killall -q polybar
pkill -9 ncat
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

PRIMARY=`xrandr --query | grep " connected " | grep "primary" | awk -F' ' '{print $1}'`

if type "xrandr"; then
  CTR=1
  WS=1
  for mon in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ "${mon}" == "${PRIMARY}" ]; then
      MONITOR=$mon polybar --reload shortcutsmain &
      MONITOR=$mon polybar --reload systray &
    else
      MONITOR=$mon polybar --reload shortcuts &
    fi
    ((WS+=4))
    i3-msg workspace ${WS} output ${mon}

    MONITOR=$mon polybar --reload middle${CTR} &
    MONITOR=$mon polybar --reload time &
    MONITOR=$mon polybar --reload network &
    MONITOR=$mon polybar --reload volume1 &
    MONITOR=$mon polybar --reload volume2 &
    MONITOR=$mon polybar --reload cpu &
    MONITOR=$mon polybar --reload memory &
    ((CTR+=1))
  done
else
    echo "No Bars loaded."
fi
