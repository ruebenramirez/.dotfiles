#!/bin/bash
set +e

BAT="Bat. $(acpi -b | awk '{ print $4 " " $5 }' | tr -d ',')"
VOL="vol. $(sh /home/rramirez/bin/volume-get.sh)"
BRIGHT="bLight. $(light -G | cut -d . -f 1)"
LOCALTIME=$(date +%m/%d\/%Y\ %r)

xsetroot -name "$BAT << $VOL << $BRIGHT << $LOCALTIME"
