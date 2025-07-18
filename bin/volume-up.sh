#!/usr/bin/env bash

VOLUME=$(pactl get-sink-volume $(pactl get-default-sink) | awk '{print $5}' | cut -d '%' -f 1)

if [[ $VOLUME -lt 100 ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
fi
