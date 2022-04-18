#!/usr/bin/env bash

set -e +x

TOUCHPAD=$(~/bin/touchpad-name)


echo "STARTING trackball setup"

# xinput --list | grep -i ergo m575
# ERGO M575 Mouse                           id=25   [slave  pointer  (2)]
TRACKBALL_DEVICE="ERGO M575 Mouse"
if [[ $(xinput list | grep "$TRACKBALL_DEVICE" | wc -l) > 0 ]]; then
    echo "trackball found: $TRACKBALL_DEVICE"

    # configurable trackball properties
    #$ xinput list-props "ERGO M575 Mouse"
    #Device 'ERGO M575 Mouse':
    #        Device Enabled (177):   1
    #        Coordinate Transformation Matrix (179): 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
    #        libinput Natural Scrolling Enabled (316):       0
    #        libinput Natural Scrolling Enabled Default (317):       0
    #        libinput Scroll Methods Available (318):        0, 0, 1
    #        libinput Scroll Method Enabled (319):   0, 0, 0
    #        libinput Scroll Method Enabled Default (320):   0, 0, 0
    #        libinput Button Scrolling Button (321): 2
    #        libinput Button Scrolling Button Default (322): 2
    #        libinput Button Scrolling Button Lock Enabled (323):    0
    #        libinput Button Scrolling Button Lock Enabled Default (324):    0
    #        libinput Middle Emulation Enabled (349):        0
    #        libinput Middle Emulation Enabled Default (350):        0
    #        libinput Accel Speed (325):     0.000000
    #        libinput Accel Speed Default (326):     0.000000
    #        libinput Accel Profiles Available (327):        1, 1
    #        libinput Accel Profile Enabled (328):   1, 0
    #        libinput Accel Profile Enabled Default (329):   1, 0
    #        libinput Left Handed Enabled (330):     0
    #        libinput Left Handed Enabled Default (331):     0
    #        libinput Send Events Modes Available (297):     1, 0
    #        libinput Send Events Mode Enabled (298):        0, 0
    #        libinput Send Events Mode Enabled Default (299):        0, 0
    #        Device Node (300):      "/dev/input/event258"
    #        Device Product ID (301):        1133, 45095
    #        libinput Drag Lock Buttons (332):       <no items>
    #        libinput Horizontal Scroll Enabled (333):       1
    #        libinput Scrolling Pixel Distance (334):        15
    #        libinput Scrolling Pixel Distance Default (335):        15


    # libinput Natural Scrolling Enabled
    #  1 boolean value (8 bit, 0 or 1). 1 enables natural scrolling
    xinput set-prop "$TRACKBALL_DEVICE" "libinput Natural Scrolling Enabled" 0

    # libinput Scroll Pixel Distance
    #   1 32-bit value (nonzero, with additional implementation-defined range checks).
    #   Changes the movement distance required to trigger one logical wheel click.
    xinput set-prop "$TRACKBALL_DEVICE" "libinput Scrolling Pixel Distance" 10

    # libinput Accel Speed
    #   1 32-bit float value, defines the pointer speed. Value range -1, 1
    xinput set-prop "$TRACKBALL_DEVICE" "libinput Accel Speed" 0.990000
fi;


echo "STARTING trackpad setup"

# configure trackpad
APPLE_TRACKPAD="Apple Inc. Magic Trackpad 2"
if [[ $(xinput list | grep "$APPLE_TRACKPAD" | wc -l) > 0 ]]; then
    echo "touchpad found: $APPLE_TRACKPAD"
    xinput set-prop "$APPLE_TRACKPAD" "libinput Tapping Enabled" 0
    xinput set-prop "$APPLE_TRACKPAD" "libinput Natural Scrolling Enabled" 1
    xinput set-prop "$APPLE_TRACKPAD" "libinput Click Method Enabled" {0 1}

    xinput set-prop "$APPLE_TRACKPAD" "libinput Accel Speed" .4
    if [[ $(~/bin/is-xps-17) -gt 0 ]]; then
        echo "speeding up cursor accel for XPS 17"
        xinput set-prop "$APPLE_TRACKPAD" "libinput Accel Speed" .85
    fi
    xinput set-prop "$APPLE_TRACKPAD" "libinput Accel Profile Enabled" 1, 0

    xinput --enable "$APPLE_TRACKPAD"
    xinput list-props "$APPLE_TRACKPAD"
fi;

# configure trackpad
if [[ $(~/bin/touchpad-name | wc -l) -gt 0 ]]; then
    echo "touchpad found: $TOUCHPAD"

    # disable tap to click
    xinput set-prop "$TOUCHPAD" "libinput Tapping Enabled" 0

    # enable natural scrolling
    xinput set-prop "$TOUCHPAD" "libinput Natural Scrolling Enabled" 1

    # set click method
    xinput set-prop "$TOUCHPAD" "libinput Click Method Enabled" {0 1}

    # set accel speed
    xinput set-prop "$TOUCHPAD" "libinput Accel Speed" .3

    if [[ $(~/bin/is-xps-17) -gt 0 ]]; then
        #echo "speeding up cursor accel for XPS 17"
        xinput set-prop "$TOUCHPAD" "libinput Accel Speed" .85
    fi
    xinput set-prop "$TOUCHPAD" "libinput Accel Profile Enabled" 1, 0

    # enable touchpad
    xinput --enable "$TOUCHPAD"

    #xinput list-props "$TOUCHPAD"
fi

echo "FINISHED mouse/trackpad setup"
