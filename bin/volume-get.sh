#!/usr/bin/env bash

pactl get-sink-volume $(pactl get-default-sink) | awk '{print $5}'
