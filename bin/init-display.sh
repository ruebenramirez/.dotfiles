#!/bin/bash

hostname=$(hostname -f)
echo '~/bin/init-display'
echo $hostname

HOME_MONITOR=$(xrandr | egrep -i 'DP.*connected' | egrep -v 'disconnected|eDP' | wc -l)

xrandr --auto
if [[ $HOME_MONITOR == 1 ]]; then
    echo "FOUND external display"
    sh ~/.screenlayout/home.sh
else
    echo "no external display"
    xrandr \
        --dpi 96 \
        --output eDP1 --mode 1600x900 --rotate normal \
        --output DP1 --off \
        --output DP2 --off \
        --output HDMI2 --off \
        --output HDMI1 --off
fi
