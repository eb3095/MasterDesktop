killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITOR1="DisplayPort-2"
MONITOR2="HDMI-A-1"
MONITOR3="DisplayPort-1"

if type "xrandr"; then
  for mon in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    case $mon in
      $MONITOR1 )
        MONITOR=$mon polybar --reload middle1 &
        MONITOR=$mon polybar --reload shortcuts &
        ;;
      $MONITOR2 )
        MONITOR=$mon polybar --reload middle2 &
        MONITOR=$mon polybar --reload shortcutsmain &
        ;;
      $MONITOR3 )
        MONITOR=$mon polybar --reload middle3 &
        MONITOR=$mon polybar --reload shortcuts &
        ;;
    esac
    if [ "$mon" == "$MONITOR2" ]; then
      MONITOR=$mon polybar --reload systray &
    fi
    MONITOR=$mon polybar --reload time &
    MONITOR=$mon polybar --reload network &
    MONITOR=$mon polybar --reload volume1 &
    MONITOR=$mon polybar --reload volume2 &
    MONITOR=$mon polybar --reload cpu &
    MONITOR=$mon polybar --reload memory &
  done
else
    echo "No Bars loaded."
fi
