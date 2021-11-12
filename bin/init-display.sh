#!/bin/bash

hostname=$(hostname -f)
echo $hostname

HOME_MONITOR=$(xrandr | egrep -i 'DP.*connected' | egrep -v 'disconnected|eDP' | wc -l)

xrandr --auto
if [[ $HOME_MONITOR == 1 ]]; then
    echo "FOUND external display"
    ~/.screenlayout/default.sh
    #~/.screenlayout/sidebyside.sh

    ~/bin/max-brightness-lepow.sh
else
    echo "no external display"
    xrandr \
        --dpi 96 \
        --output eDP1 --mode 1920x1080 --rotate normal \
        --output DP1 --off \
        --output DP2 --off \
        --output HDMI2 --off \
        --output HDMI1 --off
fi

# refresh display background now that displays are updated
$(grep feh ~/.xinitrc)
