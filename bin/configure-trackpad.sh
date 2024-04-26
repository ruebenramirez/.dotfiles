#!/usr/bin/env bash

set +e -x

echo "STARTING trackpad setup"
TRACKPAD="$(~/bin/trackpad-name)"
if [[ $(xinput list | grep "$TRACKPAD" | wc -l) > 0 ]]; then
    echo "trackpad found: $TRACKPAD"
    xinput set-prop "$TRACKPAD" "libinput Tapping Enabled" 0
    #xinput set-prop "$TRACKPAD" "libinput Tapping Enabled" 1
    xinput set-prop "$TRACKPAD" "libinput Natural Scrolling Enabled" 1
    xinput set-prop "$TRACKPAD" "Disable While Typing Enabled" 1
    xinput set-prop "$TRACKPAD" "libinput Click Method Enabled" {0 1}
    xinput set-prop "$TRACKPAD" "libinput Accel Speed" .4
    xinput set-prop "$TRACKPAD" "libinput Accel Profile Enabled" 1, 0
    xinput --enable "$TRACKPAD"
    xinput list-props "$TRACKPAD"
fi;
echo "FINISHED trackpad setup"

echo "STARTING apple trackpad setup"
# configure trackpad
#APPLE_TRACKPAD="Apple Inc. Magic Trackpad"
APPLE_TRACKPAD=20
if [[ $(xinput list | grep "$APPLE_TRACKPAD" | wc -l) > 0 ]]; then
    echo "touchpad found: $APPLE_TRACKPAD"
    xinput set-prop "$APPLE_TRACKPAD" "libinput Tapping Enabled" 0
    xinput set-prop "$APPLE_TRACKPAD" "libinput Natural Scrolling Enabled" 1
    xinput set-prop "$APPLE_TRACKPAD" "libinput Click Method Enabled" {0 1}
    xinput set-prop "$APPLE_TRACKPAD" "libinput Accel Speed" .4
    xinput set-prop "$APPLE_TRACKPAD" "libinput Accel Profile Enabled" 1, 0
fi;
echo "FINISHED apple trackpad setup"



~/bin/trackpad-toggle.sh

xinput --list-props $(~/bin/trackpad-name)
