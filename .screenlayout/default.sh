#!/bin/sh


# I don't know why, but x11 requires resetting the scale to 1x1 before changing to another value.
# If I don't do this, I end up missing half of my display on by laptops internal display.

xrandr \
    --output eDP-1 --primary --mode 1920x1080 --pos 1060x1728 --rotate normal --scale 1x1 \
    --output DP-1 --mode 3440x1440 --pos 0x0 --rotate normal --scale 1x1\
    --output HDMI-1 --off \
    --output DP-2 --off \
    --output HDMI-2 --off

xrandr \
    --output eDP-1 --primary --mode 1920x1080 --pos 1060x1728 --rotate normal  \
    --output DP-1 --mode 3440x1440 --pos 0x0 --rotate normal --scale 1.2x1.2 \
    --output HDMI-1 --off \
    --output DP-2 --off \
    --output HDMI-2 --off


#    --output eDP-1 --primary --mode 1920x1080 --pos 629x1440 --rotate normal --scale 1.5x1.5\
