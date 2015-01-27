#!/bin/bash

# move mouse to the screen left of current
# check if there's a screen left of this one...

eval $(xdotool getmouselocation --shell)

current_delta_x=$(expr $X % 1920)
echo "current delta x = $current_delta_x"

desired_delta_x=$(expr $current_delta_x - 60)
echo "desired x = $desired_delta_x"

X=$(expr $X - $desired_delta_x)
# TODO: change `y` calculation dynamically based on screen realestate
#   * will have to be aware of what x,y was before key press that triggered this
#   * only required when monitors are stacked on top of eachother in a grid-like deployment
Y=150

xdotool mousemove $X $Y
xdotool getmouselocation

