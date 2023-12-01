#!/usr/bin/env bash


# toggle notifications
dunstctl set-paused toggle

# if not silenced, then notify that notifications are on
if [[ $(dunstctl is-paused) ]]; then
    notify-send "notifications on"
fi



