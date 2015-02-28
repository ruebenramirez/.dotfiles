#!/bin/bash

# if pulseaudio daemon running: set volume info through it
if [ -f /etc/pulse/daemon.conf ]; then
    amixer -D pulse sset Master 5%+
else
    amixer sset Master 5%+
fi;
