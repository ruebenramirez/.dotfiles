#!/bin/bash

hostname=`hostname -f`

# xps 9550 xinput driver config
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "Synaptics Palm Detection" 1
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "Synaptics Palm Dimensions" 6, 300
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "Synaptics Pressure Motion" 80, 200
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "Synaptics Two-Finger Scrolling" 1, 1
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "Synaptics Tap Action" 0, 0, 0, 0, 0, 0, 0
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "Synaptics Scrolling Distance" -30, -30
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "Synaptics Finger" 32, 35, 0
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Click Method Enabled" 0 1
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Accel Speed" .95
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Tapping Enabled" 0

# Logitech M570
xinput set-prop "Logitech M570" "libinput Accel Speed" .75
xinput set-prop "Logitech M570" "libinput Accel Speed" .75
xinput set-prop "Logitech M570" "libinput Middle Emulation Enabled" 1


# Logitech MX Anywhere 2
xinput set-prop "Logitech MX Anywhere 2" "libinput Accel Speed" .95

# older thinkpad trackpad config
# source:
# https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Using_automatic_palm_detection
synclient PalmDetect=1
synclient PalmMinWidth=1
# synclient PalmMinZ=40

# disable tap clicks
synclient TapButton1=0
synclient TapButton2=0
synclient TapButton3=0

# Natural scrolling
synclient HorizTwoFingerScroll=1
synclient VertScrollDelta=-85
synclient HorizScrollDelta=-85

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
synclient FingerLow=40
synclient FingerHigh=50

# speed up the mouse cursor
synclient MinSpeed=1
synclient MaxSpeed=1.55
synclient AccelFactor=1.3
