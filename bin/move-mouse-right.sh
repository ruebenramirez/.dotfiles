#!/bin/bash

# move mouse to the screen left of current
# check if there's a screen left of this one...

eval $(xdotool getmouselocation --shell)

X=$(expr $X + 1920)
xdotool mousemove $X $Y

