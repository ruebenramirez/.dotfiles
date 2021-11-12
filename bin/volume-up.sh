#!/bin/bash

set -e +x

# # if pulseaudio daemon running: set volume info through it
# if [ -f /etc/pulse/daemon.conf ]; then
#     amixer -D pulse sset Master 5%+
# else
#     amixer sset Master 5%+
# fi;

amixer -D pulse sset Master 5%+
amixer sset Master 5%+
