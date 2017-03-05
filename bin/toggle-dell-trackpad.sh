#!/bin/bash

if [[ $(xinput --list "DLL06E4:01 06CB:7A13 Touchpad" | grep -i disabled | wc -l) > 0 ]]; then

    xinput --enable "DLL06E4:01 06CB:7A13 Touchpad"
else
    xinput --disable "DLL06E4:01 06CB:7A13 Touchpad"
fi;
