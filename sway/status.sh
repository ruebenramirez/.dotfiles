# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

wifi_network=$(~/bin/display-connected-wifi-network)

# Produces "21 days", for example
uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%a %F %H:%M")

linux_kernel_version=$(uname -r)

# Returns the battery status: "Full", "Discharging", or "Charging".
battery_status=$(cat /sys/class/power_supply/BAT0/status)
power_remaining=$(~/bin/display-power-remaining)

disk_space_used=$(df -h / | tail -1 | awk '{print $5}')

current_load=$(~/bin/display-current-load)

volume=$(~/bin/volume-get.sh)

echo  net $wifi_network "|" disk used: $disk_space_used "|" uptime: $uptime_formatted ↑ "|" $battery_status 🔋 $power_remaining "|" load: $current_load "|" $volume "|" $date_formatted
