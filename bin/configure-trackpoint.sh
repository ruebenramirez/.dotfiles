#!/usr/bin/env bash

set +e -x

echo "I'm happy with the defaults, so no need to do anything here."
exit 0

# xinput list-props $(trackpoint-name)
# 
# Device 'TPPS/2 Elan TrackPoint':
#        Device Enabled (165):   1
#        Coordinate Transformation Matrix (167): 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
#        libinput Natural Scrolling Enabled (296):       0
#        libinput Natural Scrolling Enabled Default (297):       0
#        libinput Scroll Methods Available (298):        0, 0, 1
#        libinput Scroll Method Enabled (299):   0, 0, 1
#        libinput Scroll Method Enabled Default (300):   0, 0, 1
#        libinput Button Scrolling Button (301): 2
#        libinput Button Scrolling Button Default (302): 2
#        libinput Button Scrolling Button Lock Enabled (303):    0
#        libinput Button Scrolling Button Lock Enabled Default (304):    0
#        libinput Middle Emulation Enabled (336):        1
#        libinput Middle Emulation Enabled Default (337):        0
#        libinput Accel Speed (305):     0.000000
#        libinput Accel Speed Default (306):     0.000000
#        libinput Accel Profiles Available (307):        1, 1, 1
#        libinput Accel Profile Enabled (308):   1, 0, 0
#        libinput Accel Profile Enabled Default (309):   1, 0, 0
#        libinput Accel Custom Fallback Points (310):    <no items>
#        libinput Accel Custom Fallback Step (311):      0.000000
#        libinput Accel Custom Motion Points (312):      <no items>
#        libinput Accel Custom Motion Step (313):        0.000000
#        libinput Accel Custom Scroll Points (314):      <no items>
#        libinput Accel Custom Scroll Step (315):        0.000000
#        libinput Left Handed Enabled (316):     0
#        libinput Left Handed Enabled Default (317):     0
#        libinput Send Events Modes Available (281):     1, 0
#        libinput Send Events Mode Enabled (282):        0, 0
#        libinput Send Events Mode Enabled Default (283):        0, 0
#        Device Node (284):      "/dev/input/event13"
#        Device Product ID (285):        2, 10
#        libinput Drag Lock Buttons (318):       <no items>
#        libinput Horizontal Scroll Enabled (319):       1
#        libinput Scrolling Pixel Distance (320):        15
#        libinput Scrolling Pixel Distance Default (321):        15
#        libinput High Resolution Wheel Scroll Enabled (322):    1


echo "STARTING trackpoint setup"
TRACKPOINT="$(~/bin/trackpoint-name)"
if [[ $(xinput list | grep "$TRACKPOINT" | wc -l) > 0 ]]; then
    echo "trackpoint found: $TRACKPOINT"
    #xinput set-prop "$TRACKPOINT" "libinput Accel Profile Enabled" 1, 0
    xinput --enable "$TRACKPOINT"
fi;
echo "FINISHED trackpoint setup"

xinput list-props "$TRACKPOINT"
