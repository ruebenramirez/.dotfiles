#!/usr/bin/env bash

set -e

# Logitech MX Anywhere 2
#xinput set-prop "pointer:Logitech MX Anywhere 2" "libinput Accel Speed" .95

# configure trackpad
if [[ $(~/bin/touchpad-name | wc -l) -gt 0 ]]; then
    TOUCHPAD=$(~/bin/touchpad-name)
    xinput set-prop "$TOUCHPAD" "libinput Tapping Enabled" 0
    xinput set-prop "$TOUCHPAD" "libinput Natural Scrolling Enabled" 1
    xinput set-prop "$TOUCHPAD" "libinput Click Method Enabled" {0 1}
    xinput set-prop "$TOUCHPAD" "libinput Accel Speed" .4
    # default to using the trackpoint
    xinput --enable "$TOUCHPAD"
fi

# configure trackpoint
if [[ $(~/bin/trackpoint-name | wc -l) -gt 0 ]]; then
    #TRACKPOINT="TPPS/2 Elan TrackPoint"
    #TRACKPOINT="Elan TrackPoint"
    TRACKPOINT=$(sh ~/bin/trackpoint-name)

    # default trackpoint speed
    xinput set-prop "$TRACKPOINT" "libinput Accel Speed" -.1

    # configure trackpoint speed on x1c6
    if [[ $TRACKPOINT == "TPPS/2 Elan TrackPoint" ]]; then
        xinput set-prop "$TRACKPOINT" "libinput Accel Speed" 1
    fi
fi
