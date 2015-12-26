#!/bin/bash

hostname=`hostname -f`
logger '~/bin/init-display'

if [ $hostname = 'ThinkPad' ]; then
    logger 'setting up display for newtek work thinkpad'
    xrandr --auto
    xrandr --output LVDS-1 --size 1600x900
    xrandr --output DP-1 --left-of LVDS-1
elif [ $(hostname -f) = "minfrank" ]; then
    logger 'setting up display for asus ux-305a'
    xrandr --auto
    xrandr --output HDMI1 --mode 1920x1200 --left-of eDP1
else
    logger "not sure what monitor config to use"
fi
