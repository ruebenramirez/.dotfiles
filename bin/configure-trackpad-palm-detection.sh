#!/bin/bash

# source:
# https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Using_automatic_palm_detection

synclient PalmDetect=1
synclient PalmMinWidth=8
synclient PalmMinZ=20

# disable tap clicks
synclient TapButton1=0
synclient TapButton2=0
synclient TapButton3=0

# Natural scrolling
synclient HorizTwoFingerScroll=1
synclient VertScrollDelta=-75
synclient HorizScrollDelta=-75

# higher sensitivity
# synclient FingerLow=0
# synclient FingerHigh=12

# speed up the mouse cursor
# synclient MinSpeed=1
# synclient MaxSpeed=1.5
# synclient AccelFactor=0.045
