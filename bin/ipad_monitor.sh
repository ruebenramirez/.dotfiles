#!/bin/bash

if [ "$1" == "L" ]; then
 dir="west"
 pos="left"
elif [ "$1" == "R" ]; then
 dir="east"
 pos="right"
elif [ "$1" == "U" ]; then
 dir="north"
 pos="up"
elif [ "$1" == "D" ]; then
 dir="south"
 pos="down"
else
 echo "Defaulting to \"Up\""
 dir="north"
 pos="up"
fi
chmod +x ~/.vnc/xstartup #Just in case
vncserver -alwaysshared :1 #Start the VNC server
# ipad_charge #Allow iPad charging on Linux


# TODO: replace the input value with the wireguard network interface
#   - this will allow all screen traffic to run through wireguard.
#Friendly print of the ip address for the iPad to connect to
INPUT=`ifconfig wlp0s20f3 | grep "inet addr"`
SUBSTRING=`echo $INPUT| cut -d' ' -f 2`
echo ""
echo "Ipad Monitor enabled to the $pos of the primary screen. Start VNC client on the iPad and connect to IP $SUBSTRING, port 5901"
echo "Press CTRL+C to disable the iPad monitor"
#echo "Run the share_clip.sh script in a new terminal window to enable clipboard sharing"
####

x2x -$dir -to :1 #Share the mouse and keyboard


#Cleanup before exit
function finish {
 vncserver -kill :1 #Disable the VNC server
 # ipad_charge --off #Disable USB charging
 echo "Ipad Monitor disabled." #Display the status
}

trap finish EXIT
