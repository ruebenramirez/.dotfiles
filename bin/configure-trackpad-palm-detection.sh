#!/bin/bash

hostname=`hostname -f`

# source:
# https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Using_automatic_palm_detection

synclient PalmDetect=1
synclient PalmMinWidth=6
synclient PalmMinZ=4

# disable tap clicks
synclient TapButton1=0
synclient TapButton2=0
synclient TapButton3=0

# Natural scrolling
synclient HorizTwoFingerScroll=1
synclient VertScrollDelta=-85
synclient HorizScrollDelta=-85
xmodmap -e "pointer = 1 2 3 5 4 7 6"

if [ $hostname = 'le-laptop' ]; then
    xmodmap -e "pointer = 1 2 3 4 5 6 7"
elif [ $hostname = 'my-ThinkPad' ]; then
    xmodmap -e "pointer = 1 2 3 5 4 7 6"
fi

# Configuring pressure settings helps improve palm detection!
#
# How to determine the correct pressure settings for your trackpad:
# 1) get the event id from your trackpad input device from
#   /proc/bus/input/devices
# example section:
#        I: Bus=0011 Vendor=0002 Product=0007 Version=01b1
#        N: Name="SynPS/2 Synaptics TouchPad"
#        P: Phys=isa0060/serio1/input0
#        S: Sysfs=/devices/platform/i8042/serio1/input/input5
#        U: Uniq=
#        H: Handlers=mouse0 event5 <-------- this line here!
#        B: PROP=9
#        B: EV=b
#        B: KEY=6420 30000 0 0 0
#        2) use evtest
# see the "event5" on the "H:" line....
# 2) now that we have the touchpad id, we can monitor input pressure
#   - install `evtest` package
# 	- stream trackpad input as diagnostic output with:
#		sudo evtest /dev/input/event5
#		(or whatever your event # was
# example output (your terminal is going to get flooded with a bunch of these :
#        Event: time 1474501372.822866, -------------- SYN_REPORT ------------
#        Event: time 1474501372.979851, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 1
# see the value of the `(ABS_Pressure), value 1`
# * for my T420 (with an incredibly sensitive trackpad) I wanted to discard anything under 30 (do not register these as touch events)
# * I only wanted to count anything over 45 as a touch event

# higher sensitivity
synclient FingerLow=30
synclient FingerHigh=45

# speed up the mouse cursor
synclient MinSpeed=1
synclient MaxSpeed=1.15
synclient AccelFactor=1
