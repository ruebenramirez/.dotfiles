#!/bin/bash


# take the battery line from the .xsetroot.sh file
BAT="Bat. $(acpi -b | grep -v unavailable | awk '{ print $4 " " $5 }' | tr -d ',')"

# only grab the percentage number from the .xsetroot.sh battery line
batt_num=`echo $BAT | cut -d ' ' -f2 | cut -d '%' -f 1`

# if not charging
if [ `acpi | grep -i 'Charging' | wc -l` -lt 1 ]; then

    # if battery is 5% or less send notice
    if [ `echo $batt_num` -lt 6 ]; then
        wall 'battery low: plugin now or will init auto-shutdown'
    fi

    # if battery is 2% or less then shut down before laptop dies, and corrupts boot partition.
    #   (This has been happening a lot on my SSDs)
    if [ `echo $batt_num` -lt 3 ]; then
        wall 'battery low: plugin now or will init auto-shutdown'
        poweroff
    fi
fi
