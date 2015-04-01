#!/bin/bash

if [[ $(hostname -f) = "lefrank" ]]
then
    # personal macbook pro
    xrandr --auto
    xrandr --output DP-0 --left-of LVDS-0
    xrandr --output DP-1 --left-of LVDS-0
elif [[ $(hostname -f) = "rramirez-MacBookPro" ]]
    # work machine
    xrandr --auto
    xrandr --output eDP1 --mode 1920x1200
    xrandr --output HDMI1 --right-of eDP1
    xrandr --output HDMI2 --right-of eDP1
    xrandr --output HDMI3 --left-of eDP1
else
    echo "not sure what monitor config to use"
fi
