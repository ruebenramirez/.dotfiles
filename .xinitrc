# autoload disk and thumb drives
udiskie &

export BROWSER=google-chrome-stable &

# 1280x720 = 720p X220
hash fswebcam && fswebcam -q --no-banner -r 1280x720 ~/private/login-photos/$(date +%Y-%m-%dT%H).jpg &

# lower display brightness to save battery
xbacklight -set 19

# init dropbox
#dropbox start & #is dropbox responsible for the recent machine crashes?

# "THE loop"
while true
do
    # update dwm status bar
	sudo sh .xsetroot.sh

	# Check battery level
	BATT=$( acpi -b | sed 's/.*[charging|unknown], \([0-9)*\)%.*/\1/gi' )
	STATUS=$( acpi -b | sed 's/.*: \([a-zA-Z]*\),.*/\1/gi' )
	if ([ $BATT -le 5 ] && [ $STATUS == 'Discharging' ]); then
		# Beep
		echo -e "\007" > /dev/tty10 && sleep 0.2
		echo -e "\007" > /dev/tty10 && sleep 0.2
		echo -e "\007" > /dev/tty10 && sleep 0.2
		# Blink
		echo 'on' > /proc/acpi/ibm/light && sleep 1
		echo 'off' > /proc/acpi/ibm/light
	fi

	sleep 10s
done &

# restart xbindkeys for the key mappings to start working
pkill -f xbindkeys
xbindkeys

# speed up the keybaord
xset r rate 250 60

exec dwm
