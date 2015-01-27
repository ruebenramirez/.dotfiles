#!/bin/bash

# move mouse to the screen left of current
# check if there's a screen left of this one...

eval $(xdotool getmouselocation --shell)

if [ $X -gt 1920 ]
then
    X=$(expr $X - 1920)
    xdotool mousemove $X $Y
fi

