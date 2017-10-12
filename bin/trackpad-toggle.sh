#!/bin/bash



hostname=`hostname -f`
if [ ! $hostname = 'XPS-15-9550' ]; then
    synclient TouchpadOff=$(synclient -l | grep -c 'TouchpadOff.*=.*0')

else
    if [[ $(xinput --list "DLL06E4:01 06CB:7A13 Touchpad" | grep -i disabled | wc -l) > 0 ]]; then
        xinput --enable "DLL06E4:01 06CB:7A13 Touchpad"
    else
        xinput --disable "DLL06E4:01 06CB:7A13 Touchpad"
    fi;
fi;
