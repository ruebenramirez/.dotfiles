#!/bin/bash
set +e

BAT="Bat. $(acpi -b | awk '{ print $4 " " $5 }' | tr -d ',')"
VOL="vol. $(amixer -D pulse get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')"
BRIGHT="bLight. $(light -G | cut -d . -f 1)"
LOCALTIME=$(date +%m/%d\/%Y\ %r)

xsetroot -name "$BAT << $VOL << $BRIGHT << $LOCALTIME"
