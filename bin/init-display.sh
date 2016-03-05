#!/bin/bash

hostname=`hostname -f`
logger '~/bin/init-display'

if [ $hostname = 'ThinkPad' ]; then
    logger 'setting up display for newtek work thinkpad'
    xrandr --auto
    xrandr --output LVDS-0 --size 1600x900
    xrandr --output DP-3 --left-of LVDS-0
elif [ $hostname = 'ThinkPad-X220' ]; then
    logger 'setting up display for x220'
    xrandr --auto
    xrandr --output LVDS1 --size 1366x768
    xrandr --output DP1 --left-of LVDS1
    xrandr --output HDMI1 --left-of LVDS1
    xrandr --output VGA1 --left-of LVDS1
elif [ $(hostname -f) = "minfrank" ]; then
    logger 'setting up display for asus ux-305a'
    xrandr --auto
    xrandr --output HDMI1 --mode 1920x1200 --left-of eDP1
elif [ $(hostname -f) = "frankenmac" ]; then
    logger 'setting up display for (12,1) macbook pro 13'
    xrandr --auto
    xrandr --output eDP1 --mode 1920x1200
    xrandr --output DP1 --left-of eDP1
    xrandr --output DP2 --left-of eDP1
    xrandr --output HDMI1 --left-of eDP1
    xrandr --output HDMI2 --left-of eDP1
else
    logger "not sure what monitor config to use"
fi
