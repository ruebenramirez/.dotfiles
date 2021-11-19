# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

wifi_network=$(~/bin/display-connected-wifi-network)

# Produces "21 days", for example
uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%a %F %H:%M")

# Get the Linux version but remove the "-1-ARCH" part
linux_version=$(uname -r | cut -d '-' -f1)

# Returns the battery status: "Full", "Discharging", or "Charging".
battery_status=$(cat /sys/class/power_supply/BAT0/status)
power_remaining=$(~/bin/display-power-remaining)

disk_space_used=$(df -h / | tail -1 | awk '{print $5}')

current_load=$(~/bin/display-current-load)

bt_headphones=$(~/bin/display-bluetooth-headset-connected)

# Emojis and characters for the status bar
# 💎 💻 💡 🔌 ⚡ 📁 \|
echo $bt_headphones "|" disk used: $disk_space_used "|" wifi $wifi_network "|" uptime: $uptime_formatted ↑ "|" kernel v$linux_version 🐧 "|" $battery_status 🔋 $power_remaining "|" load: $current_load "|" $date_formatted
