#!/bin/bash

if [[ $(sudo cat /sys/devices/virtual/dmi/id/chassis_vendor | grep -i apple | wc -l) > 0 || $(sudo lsusb | egrep -i "apple.*keyboard" | wc -l) -ge 1 ]]; then
    echo "setting up apple keyboard"

	#echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
	echo 1 | sudo tee /sys/module/hid_apple/parameters/fnmode
	echo 0 | sudo tee /sys/module/hid_apple/parameters/iso_layout
	echo 1 | sudo tee /sys/module/hid_apple/parameters/swap_opt_cmd
	xmodmap ~/.xmodmaprc
fi
