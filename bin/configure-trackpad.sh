#!/usr/bin/env bash

set -e +x

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
