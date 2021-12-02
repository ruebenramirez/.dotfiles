#!/bin/sh

xrandr --auto

xrandr --output eDP-1 --primary --mode 3840x2400 --pos 960x3240 --rotate normal --scale 1x1 \
    --output DP-1 --off --output DP-2 --off \
    --output DP-3 --mode 3840x2160 --pos 0x0 --rotate normal --scale 1.5x1.5 \
    --output DP-4 --off --output DP-1-0 --off --output DP-1-1 --off --output DP-1-2 --off --output DP-1-3 --off --output DP-1-4 --off --output DP-1-5 --off --output DP-1-6 --off --output DP-1-7 --off
