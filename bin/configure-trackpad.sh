#!/usr/bin/env bash

set -e +x

TOUCHPAD=$(~/bin/touchpad-name)

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
        xinput set-prop "$APPLE_TRACKPAD" "libinput Accel Speed" .8
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
    xinput set-prop "$TOUCHPAD" "libinput Accel Speed" .4

    if [[ $(~/bin/is-xps-17) -gt 0 ]]; then
        echo "speeding up cursor accel for XPS 17"
        xinput set-prop "$TOUCHPAD" "libinput Accel Speed" .8
    fi
    xinput set-prop "$TOUCHPAD" "libinput Accel Profile Enabled" 1, 0

    # enable touchpad
    xinput --enable "$TOUCHPAD"
    xinput list-props "$TOUCHPAD"
fi

echo "FINISHED mouse/trackpad setup"
