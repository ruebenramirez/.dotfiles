#!/bin/bash
set +e

BAT="Bat. $(acpi -b | grep -v unavailable | awk '{ print $4 " " $5 }' | tr -d ',')"
VOL="$(sh /home/rramirez/bin/volume-get.sh)"
BRIGHT="bLight. $(light -G | cut -d . -f 1)"
WIFI="wifi: $(nmcli -t -f active,ssid dev wifi | grep ^yes | cut -d ':' -f 2)"
VPN="$VPN$(test $(pgrep 'forticlient' | wc -l) -gt 1 && echo '<< VPN-NewTek ')"
CPU_TEMP="CPU temp: $(sensors | grep "Physical id 0" | awk '{ print $4 }')"
LOCALTIME=$(date +%m/%d\/%Y\ %r)

feh --bg-scale ~/.dotfiles/desktop-background/minimalism_telephone_computer_technology_99028_1600x900.jpg

xsetroot -name "$BAT << $VOL << $WIFI << $BRIGHT $VPN<< $CPU_TEMP << $LOCALTIME"
