#!/bin/bash

hostname=`hostname -f`
echo '~/bin/init-display'
echo $hostname

xrandr --auto

if [ $hostname = 'ThinkPad' ]; then
    echo 'setting up display for newtek w520';
    xrandr --output LVDS2 --mode 1600x900
    xrandr --output DP-1-1 --above LVDS2
elif [ $hostname = 'my-ThinkPad' ]; then
    echo 'setting up display for personal w520'
    xrandr --output LVDS-0 --mode 1920x1080
    xrandr --output DisplayPort-0 --above LVDS-0
    xrandr --output DisplayPort-2 --above LVDS-0
    xrandr --output LVDS1 --mode 1920x1080
    xrandr --output DP-1-2 --above LVDS1
elif [ $hostname = 'le-laptop' ]; then
    echo 'setting up display for x220'
    xrandr --output LVDS1 --mode 1366x768
    xrandr --output DP1 --auto --above LVDS1
    xrandr --output DP2 --auto --above LVDS1
    xrandr --output HDMI1 --auto --left-of LVDS1
    xrandr --output VGA1 --auto --above LVDS1
elif [ $hostname = "frankenmac" ]; then
    echo 'setting up display for (12,1) macbook pro 13'
    xrandr --output eDP1 --mode 1920x1200
    xrandr --output DP1 --above eDP1 --mode 2560x1440
    xrandr --output DP1 --above eDP1 --mode 3440x1440
    xrandr --output DP2 --above eDP1 --mode 2560x1440
    xrandr --output DP2 --above eDP1 --mode 3440x1440
    xrandr --output HDMI1 --above eDP1
    xrandr --output HDMI2 --above eDP1
else
    echo 'not sure what monitor config to use';
fi
