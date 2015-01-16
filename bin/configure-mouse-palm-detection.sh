#!/bin/bash

# source: 
# https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Using_automatic_palm_detection

synclient PalmDetect=1
synclient PalmMinWidth=12
synclient PalmMinZ=200

# disable tap clicks
synclient TapButton1=0
synclient TapButton2=0
synclient TapButton3=0

# Natural scrolling
synclient VertScrollDelta=-111
synclient HorizScrollDelta=-111
