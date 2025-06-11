#!/usr/bin/env bash

pactl list sinks | grep -C5 RUNNING | grep Description | cut -d' ' -f 2
