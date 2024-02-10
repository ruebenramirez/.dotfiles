#!/usr/bin/env bash

TRACKPAD="$(~/bin/trackpad-name)"
if [[ $(xinput --list "$TRACKPAD" | grep -ic disabled) > 0 ]]; then
    xinput --enable "$TRACKPAD"
else
    xinput --disable "$TRACKPAD"
fi;

