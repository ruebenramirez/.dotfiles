#!/bin/bash

# source: 
# https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Using_automatic_palm_detection

synclient PalmDetect=1
synclient PalmMinWidth=12
synclient PalmMinZ=200
