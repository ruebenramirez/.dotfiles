#!/usr/bin/env bash

# source: https://github.com/alexeygumirov/lofree-flow-fn-fix

# if function lock disabled, toggle it on
if [[ $(cat /sys/module/hid_apple/parameters/fnmode) == "2" ]]; then
    # 1 - use F1, F2, F3, etc.
    sudo sh -c 'echo 1 > /sys/module/hid_apple/parameters/fnmode'
    exit 1;
fi

# if function lock enabled, toggle it off
# 2 - use alt media key presses instead of the Function keys
sudo sh -c 'echo 2 > /sys/module/hid_apple/parameters/fnmode'
