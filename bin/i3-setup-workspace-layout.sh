#!/usr/bin/env bash

set -e

# large monitor attached
if [[ $(xrandr | grep -v 'eDP-1' | grep 'DP-1 connected' | wc -l) -gt 0 ]]; then
    i3-msg workspace 1, move workspace up
    i3-msg workspace 2, move workspace up
    i3-msg workspace 9, move workspace up
    # i3-msg workspace 1, layout default
    # i3-msg workspace 2, layout default
    # i3-msg workspace 9, layout default
fi

# only laptop display
# if [[ $(xrandr | grep -v eDP-1 | grep 'DP-1 connected' | wc -l) == 0 ]]; then
#     i3-msg workspace 1, move workspace down
#     i3-msg workspace 2, move workspace down
#     i3-msg workspace 9, move workspace down
#     i3-msg workspace 1, layout tabbed
#     i3-msg workspace 2, layout tabbed
#     i3-msg workspace 9, layout tabbed
# fi
