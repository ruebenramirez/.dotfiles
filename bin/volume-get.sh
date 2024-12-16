#!/usr/bin/env bash

if [[ $(pactl get-sink-mute $(pactl get-default-sink) | grep -ic 'yes')  -gt 0 ]]; then
    echo "MUTED"
    exit 1
fi

pactl get-sink-volume $(pactl get-default-sink) | awk '{print $5}'
