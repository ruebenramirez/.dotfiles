#!/usr/bin/env bash

pactl list sinks | egrep -C5 "IDLE|RUNNING" | grep Description | cut -d' ' -f 2
