#!/bin/bash

if [[ $(hostname -f) = "lefrank" ]]
then
    # Personal MacBookPro
    xrandr --auto
    xrandr --output DP-0 --left-of LVDS-0
    xrandr --output DP-1 --left-of LVDS-0
elif [[ $(hostname -f) = "rramirez-dev-vm" ]]
then
    # Dev VM 
    xrandr --auto
    xrandr --output Virtual1 --mode 1360x768
elif [[ $(hostname -f) = "minfrank" ]]
then
    # Work Machine
    xrandr --auto
    xrandr --output eDP1 --mode 1920x1080
    xrandr --output HDMI1 --mode 1920x1200 --left-of eDP1
    # xrandr --output eDP1 --mode 1920x1080
    # xrandr --output HDMI1 --mode 1920x1200 --above eDP1
else
    echo "not sure what monitor config to use"
fi
