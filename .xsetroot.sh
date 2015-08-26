#!/bin/bash
set +e

BAT="Bat. $(acpi -b | grep -v unavailable | awk '{ print $4 " " $5 }' | tr -d ',')"
VOL="$(sh /home/rramirez/bin/volume-get.sh)"
BRIGHT="bLight. $(light -G | cut -d . -f 1)"
LOCALTIME=$(date +%m/%d\/%Y\ %r)
VPN="$(test $(ps aux | grep -i 'openconnect.*rackspace' | wc -l) -gt 1 && echo '<< VPN-Rackspace ')"
VPN="$VPN$(test $(ps aux | grep -i 'vpnc nt.conf' | wc -l) -gt 1 && echo '<< VPN-NewTek ')"


xsetroot -name "$BAT << $VOL << $BRIGHT $VPN<< $LOCALTIME"
