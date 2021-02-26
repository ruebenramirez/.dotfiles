#!/bin/bash

set +e +x

# Logitech MX Anywhere 2
#xinput set-prop "pointer:Logitech MX Anywhere 2" "libinput Accel Speed" .95

TOUCHPAD="$(xinput --list --name-only | grep -i touchpad)"
xinput set-prop "$TOUCHPAD" "libinput Tapping Enabled" 0
xinput set-prop "$TOUCHPAD" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$TOUCHPAD" "libinput Click Method Enabled" {0 1}
xinput set-prop "$TOUCHPAD" "libinput Accel Speed" .4
# default to using the trackpoint
xinput --enable "$TOUCHPAD"

#TRACKPOINT="TPPS/2 Elan TrackPoint"
TRACKPOINT="Elan TrackPoint"
xinput set-prop "$TRACKPOINT" "libinput Accel Speed" -.1
#xinput set-prop "$TRACKPOINT" "libinput Accel Speed" 1
