#!/bin/bash

TOUCHPAD=$(sh ~/bin/touchpad-name)
if [[ $(xinput --list "$TOUCHPAD" | grep -i disabled | wc -l) > 0 ]]; then
    xinput --enable "$TOUCHPAD"
else
    xinput --disable "$TOUCHPAD"
fi;

