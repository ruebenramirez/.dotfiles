#!/bin/bash

TOUCHPAD_STATE="$(gsettings get org.gnome.desktop.peripherals.touchpad send-events)"
if [[ $(echo "$TOUCHPAD_STATE" | grep -i enabled | wc -l) > 0 ]]; then
    gsettings set org.gnome.desktop.peripherals.touchpad send-events 'disabled'
else
    gsettings set org.gnome.desktop.peripherals.touchpad send-events 'enabled'
fi;
