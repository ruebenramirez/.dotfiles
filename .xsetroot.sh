#!/bin/bash

VOL=$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
LOCALTIME=$(date +%m/%d\/%Y\ \<\<\ %r)
#OTHERTIME=$(TZ=Europe/London date +%Z\=%I:%M)
#IP=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1) # can get confused if you use vmware
TEMP="$((($(cat /sys/class/thermal/thermal_zone0/temp) / 1000)*9/5+32))F"
BRIGHT="bLight. $(xbacklight -get | cut -d . -f 1)"
BAT="Bat. $(acpi -b | awk '{ print $4 " " $5 }' | tr -d ',')"

# do we want to display GMT?
#xsetroot -name "$IP << $BAT << vol$VOL << $TEMP << $LOCALTIME << $OTHERTIME"

# do we want display the IP address?
#xsetroot -name "$IP << $BAT << vol$VOL << $TEMP << $LOCALTIME"

xsetroot -name "$BAT << vol$VOL << $BRIGHT << $LOCALTIME"
