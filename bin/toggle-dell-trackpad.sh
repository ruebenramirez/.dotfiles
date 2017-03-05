#!/bin/bash

if [[ $(xinput --list "DLL06E4:01 06CB:7A13 Touchpad" | grep -i disabled | wc -l) > 0 ]]; then
    notify-send "enabling touchpad"
    xinput --enable "DLL06E4:01 06CB:7A13 Touchpad"
    killall imwheel
else
    notify-send "disabling touchpad"
    xinput --disable "DLL06E4:01 06CB:7A13 Touchpad"
    imwheel &
fi;
