#!/bin/bash

VOL=""

# if pulseaudio daemon running: get volume info from it
if [ -f /etc/pulse/daemon.conf ]; then
    VOL="$(amixer -D pulse get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')"
else
    VOL="$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')"
fi;

echo "vol. $VOL"
