#!/bin/bash

hostname=`hostname -f`
echo '~/bin/init-display'
echo $hostname

if [ $hostname = 'ThinkPad' ]; then
    echo 'setting up display for newtek w520';
    xrandr --auto
    xrandr --output LVDS-0 --mode 1600x900
    xrandr --output DP-3 --left-of LVDS-0
elif [ $hostname = 'my-ThinkPad' ]; then
    logger 'setting up display for personal w520'
    xrandr --auto
    xrandr --output LVDS-0 --mode 1920x1080
    xrandr --output DisplayPort-0 --left-of LVDS-0
elif [ $hostname = 'ThinkPad-X220' ]; then
    logger 'setting up display for x220'
    xrandr --auto
    xrandr --output LVDS1 --mode 1366x768
    xrandr --output DP1 --left-of LVDS1
    xrandr --output HDMI1 --left-of LVDS1
    xrandr --output VGA1 --left-of LVDS1
elif [ $hostname = "frankenmac" ]; then
    logger 'setting up display for (12,1) macbook pro 13'
    xrandr --auto
    xrandr --output eDP1 --mode 1920x1200
    xrandr --output DP1 --left-of eDP1
    xrandr --output DP2 --left-of eDP1
    xrandr --output HDMI1 --left-of eDP1
    xrandr --output HDMI2 --left-of eDP1
else
    echo 'not sure what monitor config to use';
fi
