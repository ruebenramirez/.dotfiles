#!/usr/bin/env bash

TRACKPAD=$(sh ~/bin/trackpad-name)
if [[ $(xinput --list "$TRACKPAD" | grep -ic disabled) > 0 ]]; then
    xinput --enable "$TRACKPAD"
else
    xinput --disable "$TRACKPAD"
fi;

