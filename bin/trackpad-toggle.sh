#!/bin/bash

# TODO: check if gnome shell is running
# TOUCHPAD_STATE="$(gsettings get org.gnome.desktop.peripherals.touchpad send-events)"
# if [[ $(echo "$TOUCHPAD_STATE" | grep -i enabled | wc -l) > 0 ]]; then
#     gsettings set org.gnome.desktop.peripherals.touchpad send-events 'disabled'
# else
#     gsettings set org.gnome.desktop.peripherals.touchpad send-events 'enabled'
# fi;


TOUCHPAD="SynPS/2 Synaptics TouchPad"
if [[ $(xinput --list "$TOUCHPAD" | grep -i disabled | wc -l) > 0 ]]; then
    xinput --enable "$TOUCHPAD"
else
    xinput --disable "$TOUCHPAD"
fi;

