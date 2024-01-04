#!/usr/bin/env bash

set +e -x

echo "STARTING trackpad setup"
TRACKPAD="$(~/bin/trackpad-name)"
if [[ $(xinput list | grep "$TRACKPAD" | wc -l) > 0 ]]; then
    echo "trackpad found: $TRACKPAD"
    xinput set-prop "$TRACKPAD" "libinput Tapping Enabled" 0
    #xinput set-prop "$TRACKPAD" "libinput Tapping Enabled" 1
    xinput set-prop "$TRACKPAD" "libinput Natural Scrolling Enabled" 1
    xinput set-prop "$TRACKPAD" "libinput Click Method Enabled" {0 1}
    xinput set-prop "$TRACKPAD" "libinput Accel Speed" .85
    #xinput set-prop "$TRACKPAD" "libinput Accel Speed" .4
    xinput set-prop "$TRACKPAD" "libinput Accel Profile Enabled" 1, 0
    xinput --enable "$TRACKPAD"
    xinput list-props "$TRACKPAD"
fi;
echo "FINISHED trackpad setup"



~/bin/trackpad-toggle.sh
