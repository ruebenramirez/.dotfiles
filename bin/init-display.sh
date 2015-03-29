#!/bin/bash

if [[ $(hostname -f) = "lefrank" ]]
then
    xrandr --auto
    xrandr --output DP-0 --left-of LVDS-0
    xrandr --output DP-1 --left-of LVDS-0
elif [[ $(hostname -f) = "rramirez-dev-vm" ]]
then
    xrandr --output Virtual1 --mode 1360x768
else
    # work machine
    xrandr --auto
    xrandr --output eDP1 --mode 1920x1200
    xrandr --output HDMI2 --right-of eDP1
    xrandr --output HDMI3 --left-of eDP1
fi
