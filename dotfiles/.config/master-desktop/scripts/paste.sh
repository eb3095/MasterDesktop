#!/bin/bash

/usr/bin/sleep .5
/usr/bin/xclip -o -selection clipboard | /usr/bin/xdotool type --delay 20 --file -
