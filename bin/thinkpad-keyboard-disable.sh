#!/usr/bin/env bash

# Set environment for Sway
export SWAYSOCK="/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock"

# Log the action
echo "$(date): Disabling laptop keyboard - Flow84@Lofree connected" >> /tmp/keyboard-toggle.log

# Disable the laptop keyboard via Sway using exact identifier
swaymsg input "1:1:AT_Translated_Set_2_keyboard" events disabled

# Alternative: Use kernel inhibition method if needed
# echo 1 | sudo tee /sys/class/input/input*/inhibited 2>/dev/null | head -1

exit 0
