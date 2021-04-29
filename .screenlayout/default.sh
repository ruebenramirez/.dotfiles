#!/bin/sh
xrandr \
    --output eDP-1 --primary --mode 1920x1080 --pos 629x1440 --rotate normal --scale 1x1 \
    --output DP-1 --mode 3440x1440 --pos 0x0 --rotate normal \
    --output HDMI-1 --off \
    --output DP-2 --off \
    --output HDMI-2 --off
xrandr \
    --output eDP-1 --primary --mode 1920x1080 --pos 629x1440 --rotate normal --scale .75x.75 \
    --output DP-1 --mode 3440x1440 --pos 0x0 --rotate normal \
    --output HDMI-1 --off \
    --output DP-2 --off \
    --output HDMI-2 --off



#    --output eDP-1 --primary --mode 1920x1080 --pos 629x1440 --rotate normal --scale 1.5x1.5\
