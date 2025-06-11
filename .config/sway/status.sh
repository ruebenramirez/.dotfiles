# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

vpn_connection=$(~/bin/display-vpn-connection)

wifi_network=$(~/bin/display-connected-wifi-network)

# Produces "21 days", for example
uptime_formatted=$(uptime | cut -d ',' -f1 | awk '{$1=""; print $0}' | xargs echo)

linux_kernel_version=$(uname -r)

# Returns the battery status: "Full", "Discharging", or "Charging".
battery_status=$(cat /sys/class/power_supply/BAT0/status)
power_remaining=$(~/bin/display-power-remaining)

disk_space_used=$(df -h / | tail -1 | awk '{print $5}')

current_load=$(~/bin/display-current-load)

volume=$(~/bin/volume-get.sh)
sound_device=$(~/bin/sound-output-device-name.sh)

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%b %F %a @ %H:%M")

echo -e "VPN" $vpn_connection "|" "net" $wifi_network "|" disk used: $disk_space_used "|" uptime: $uptime_formatted ↑ "|" $battery_status 🔋 $power_remaining "|" load: $current_load "|" "\U0001F3B5" $volume $sound_device "|" $date_formatted
