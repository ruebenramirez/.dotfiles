#!/usr/bin/env bash

set +e -x

echo "STARTING trackball setup"
TRACKBALL_DEVICE=$(xinput --list | grep "MX Ergo" | cut -d '=' -f 2 | cut -f 1)
if [[ $(xinput list | grep "$TRACKBALL_DEVICE" | wc -l) > 0 ]]; then
    echo "trackball found: Logitech MX Ergo Trackball"
#   [~]$ xinput list-props 17
#Device 'Logitech MX Ergo Multi-Device Trackball ':
#        Device Enabled (187):   1
#        Coordinate Transformation Matrix (189): 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
#        libinput Natural Scrolling Enabled (322):       0
#        libinput Natural Scrolling Enabled Default (323):       0
#        libinput Scroll Methods Available (324):        0, 0, 1
#        libinput Scroll Method Enabled (325):   0, 0, 1
#        libinput Scroll Method Enabled Default (326):   0, 0, 0
#        libinput Button Scrolling Button (327): 2
#        libinput Button Scrolling Button Default (328): 2
#        libinput Button Scrolling Button Lock Enabled (329):    1
#        libinput Button Scrolling Button Lock Enabled Default (330):    0
#        libinput Middle Emulation Enabled (353):        0
#        libinput Middle Emulation Enabled Default (354):        0
#        libinput Rotation Angle (628):  0.000000
#        libinput Rotation Angle Default (629):  0.000000
#        libinput Accel Speed (331):     0.000000
#        libinput Accel Speed Default (332):     0.000000
#        libinput Accel Profiles Available (333):        1, 1
#        libinput Accel Profile Enabled (334):   1, 0
#        libinput Accel Profile Enabled Default (335):   1, 0
#        libinput Left Handed Enabled (336):     0
#        libinput Left Handed Enabled Default (337):     0
#        libinput Send Events Modes Available (307):     1, 0
#        libinput Send Events Mode Enabled (308):        0, 0
#        libinput Send Events Mode Enabled Default (309):        0, 0
#        Device Node (310):      "/dev/input/event17"
#        Device Product ID (311):        1133, 45085
#        libinput Drag Lock Buttons (338):       <no items>
#        libinput Horizontal Scroll Enabled (339):       1

    xinput set-prop "$TRACKBALL_DEVICE" "libinput Accel Speed" .85
    xinput set-prop "$TRACKBALL_DEVICE" "libinput Scroll Method Enabled" 0, 0, 1
    xinput set-prop "$TRACKBALL_DEVICE" "libinput Button Scrolling Button Lock Enabled" 1
fi;
echo "FINISHED trackball setup"


echo "STARTING apple trackpad setup"
# configure trackpad
APPLE_TRACKPAD="Apple Inc. Magic Trackpad 2"
if [[ $(xinput list | grep "$APPLE_TRACKPAD" | wc -l) > 0 ]]; then
    echo "touchpad found: $APPLE_TRACKPAD"
    xinput set-prop "$APPLE_TRACKPAD" "libinput Tapping Enabled" 0
    xinput set-prop "$APPLE_TRACKPAD" "libinput Natural Scrolling Enabled" 1
    xinput set-prop "$APPLE_TRACKPAD" "libinput Click Method Enabled" {0 1}
    xinput set-prop "$APPLE_TRACKPAD" "libinput Accel Speed" .4
    xinput set-prop "$APPLE_TRACKPAD" "libinput Accel Profile Enabled" 1, 0

    if [[ $(~/bin/is-xps-17) -gt 0 ]]; then
        echo "speeding up cursor accel for XPS 17"
        xinput set-prop "$APPLE_TRACKPAD" "libinput Accel Speed" .85
    fi
    xinput --enable "$APPLE_TRACKPAD"
    #xinput list-props "$APPLE_TRACKPAD"
fi;
echo "FINISHED apple trackpad setup"

echo "STARTING trackpad setup"

TOUCHPAD=$(~/bin/touchpad-name)
TOUCHPADS_FOUND=$(echo $TOUCHPAD | wc -l)

# configure trackpad
if [[ $TOUCHPADS_FOUND -gt 0 ]]; then
    echo "touchpad found: $TOUCHPAD"
    xinput set-prop "$TOUCHPAD" "libinput Tapping Enabled" 0
    xinput set-prop "$TOUCHPAD" "libinput Natural Scrolling Enabled" 1
    xinput set-prop "$TOUCHPAD" "libinput Click Method Enabled" {0 1}
    xinput set-prop "$TOUCHPAD" "libinput Accel Speed" .3
    xinput set-prop "$TOUCHPAD" "libinput Accel Profile Enabled" 1, 0

    if [[ $(~/bin/is-xps-17) -gt 0 ]]; then
        echo "speeding up cursor accel for XPS 17"
        xinput set-prop "$TOUCHPAD" "libinput Accel Speed" .85
    fi
    xinput --enable "$TOUCHPAD"
    #xinput list-props "$TOUCHPAD"
fi

echo "FINISHED mouse/trackpad setup"
