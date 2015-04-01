#!/bin/bash

if [[ $(hostname -f) = "lefrank" ]]
then
    # personal macbook pro
    xrandr --auto
    xrandr --output DP-0 --left-of LVDS-0
    xrandr --output DP-1 --left-of LVDS-0
<<<<<<< HEAD
elif [[ $(hostname -f) = "rramirez-MacBookPro" ]]
=======
elif [[ $(hostname -f) = "rramirez-dev-vm" ]]
then
    xrandr --output Virtual1 --mode 1360x768
else
>>>>>>> 8b2a3303e9323902d8686faa958b677bc1f6c255
    # work machine
    xrandr --auto
    xrandr --output eDP1 --mode 1920x1200
    xrandr --output HDMI1 --right-of eDP1
    xrandr --output HDMI2 --right-of eDP1
    xrandr --output HDMI3 --left-of eDP1
else
    echo "not sure what monitor config to use"
fi
