#!/bin/bash

if [[ $(cat /sys/devices/virtual/dmi/id/chassis_vendor | grep -i apple | wc -l) > 0 ]]; then
    # setup keyboard
    pushd /home/rramirez/.dotfiles && make macbookpro_keyboard && pushd
fi
