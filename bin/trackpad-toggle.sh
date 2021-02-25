#!/bin/bash

TOUCHPAD="$(xinput --list --name-only | grep -i touchpad)"
if [[ $(xinput --list "$TOUCHPAD" | grep -i disabled | wc -l) > 0 ]]; then
    xinput --enable "$TOUCHPAD"
else
    xinput --disable "$TOUCHPAD"
fi;

